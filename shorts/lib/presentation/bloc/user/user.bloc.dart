import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/constant/error_code.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/domain/usecase/module/user/account.usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/exception/custom_exception.dart';
import '../../../domain/usecase/module/user/auth.usecase.dart';

part 'user.event.dart';

part 'user.state.dart';

@singleton
class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthUseCase _authUseCase;
  final AccountUseCase _accountUseCase;

  User? get currentUser => _authUseCase.currentUser();

  Stream<User?> get authStream => _authUseCase.authStream();

  UserBloc(
      {required AuthUseCase authUseCase,
      required AccountUseCase accountUseCase})
      : _authUseCase = authUseCase,
        _accountUseCase = accountUseCase,
        super(NotAuthenticatedState()) {
    on<InitUserEvent>(_onInit);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignInWithEmailAndPasswordEvent>(_onSignInWithEmailAndPassword);
    on<SignUpWithEmailAndPasswordEvent>(_onSignUpWithEmailAndPassword);
    on<OnBoardingEvent>(_onOnBoarding);
    on<FetchAccountEvent>(_onFetchAccount);
    on<SignOutEvent>(_onSignOut);
    on<EditProfileEvent>(_onEditProfile);
  }

  Future<void> _onInit(InitUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      emit(NotAuthenticatedState());
    } catch (error) {
      log(error.toString());
      emit(UserFailureState(
          (error is CustomException) ? error.message : '인증상태 초기화 실패'));
    }
  }

  Future<void> _onSignInWithGoogle(
      SignInWithGoogleEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await _authUseCase
          .signInWithGoogle()
          .then((res) => res.fold((l) => throw l.toCustomException(), (r) {
                final sessionUser = _authUseCase.currentUser();
                sessionUser != null
                    ? emit(OnBoardingState(sessionUser))
                    : emit(NotAuthenticatedState());
              }));
    } catch (error) {
      log(error.toString());
      emit(UserFailureState(
          (error is CustomException) ? error.message : '구글 로그인 실패'));
    }
  }

  Future<void> _onSignInWithEmailAndPassword(
      SignInWithEmailAndPasswordEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await _authUseCase
          .signInWithEmailAndPassword(
              email: event.email, password: event.password)
          .then((res) => res.fold((l) => throw l.toCustomException(), (r) {
                final sessionUser = _authUseCase.currentUser();
                sessionUser != null
                    ? emit(OnBoardingState(sessionUser))
                    : emit(NotAuthenticatedState());
              }));
    } catch (error) {
      log(error.toString());
      emit(UserFailureState(
          (error is CustomException) ? error.message : '로그인 실패'));
    }
  }

  Future<void> _onSignUpWithEmailAndPassword(
      SignUpWithEmailAndPasswordEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await _authUseCase
          .signUpWithEmailAndPassword(
              email: event.email, password: event.password)
          .then((res) => res.fold((l) => throw l.toCustomException(), (r) {
                final sessionUser = _authUseCase.currentUser();
                sessionUser != null
                    ? emit(OnBoardingState(sessionUser))
                    : emit(NotAuthenticatedState());
              }));
    } catch (error) {
      log(error.toString());
      emit(UserFailureState(
          (error is CustomException) ? error.message : '회원가입 실패'));
    }
  }

  Future<void> _onOnBoarding(
      OnBoardingEvent event, Emitter<UserState> emit) async {
    try {
      final sessionUser = currentUser!;
      emit(UserLoadingState());
      final res = await _accountUseCase.onBoarding(
          sessionUser: sessionUser,
          image: event.image,
          nickname: event.nickname,
          description: event.description);
      res.fold((l) => throw l.toCustomException(),
          (r) => emit(UserLoadedState(sessionUser: sessionUser, account: r)));
    } catch (error) {
      log(error.toString());
      emit(UserFailureState(
          (error is CustomException) ? error.message : 'OnBoarding 중 오류 발생'));
    }
  }

  Future<void> _onFetchAccount(
      FetchAccountEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await _accountUseCase.getCurrentUser().then((res) => res.fold(
          (l) => throw l.toCustomException(),
          (r) => emit(
              UserLoadedState(sessionUser: event.sessionUser, account: r))));
    } catch (error) {
      log(error.toString());
      if (error is CustomException) {
        switch (error.code) {
          case ErrorCode.databaseError:
            emit(OnBoardingState(event.sessionUser));
            return;
          case ErrorCode.networkConnectionError:
            emit(const UserFailureState('네트워크 오류'));
            return;
          default:
            emit(const UserFailureState('알수 없는 오류 오류'));
            return;
        }
      } else {
        emit(const UserFailureState('알수 없는 오류 오류'));
      }
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await _authUseCase.signOut();
      emit(NotAuthenticatedState());
    } catch (error) {
      log(error.toString());
      emit(UserFailureState(
          (error is CustomException) ? error.message : '로그아웃 실패'));
    }
  }

  Future<void> _onEditProfile(
      EditProfileEvent event, Emitter<UserState> emit) async {
    try {
      if (state is! UserLoadedState) {
        throw const AuthException('로그인하지 않은 유저');
      }
      final temp = state as UserLoadedState;
      String profileUrl = temp.account.profileUrl!;
      emit(UserLoadingState());
      if (event.image != null) {
        await _accountUseCase
            .upsertProfileImage(event.image!)
            .then((res) => res.fold((l) => emit(temp), (r) {
                  profileUrl = r;
                }));
      }
      // 유저 정보 수정
      final account = event.account.copyWith(profileUrl: profileUrl);
      await _accountUseCase.upsertUser(account).then((res) => res.fold(
          (l) => emit(temp),
          (r) => emit(UserLoadedState(
              sessionUser: temp.sessionUser, account: account))));
    } catch (error) {
      log(error.toString());
      emit(UserFailureState(
          (error is CustomException) ? error.message : '알수 없는 오류'));
    }
  }
}
