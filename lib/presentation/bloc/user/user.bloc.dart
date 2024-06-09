import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/domain/usecase/module/user/account.usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    on<FetchAccountEvent>(_onFetchAccount);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onInit(InitUserEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      emit(NotAuthenticatedState());
    } catch (error) {
      log(error.toString());
      emit(UserFailureState());
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
      emit(UserFailureState());
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
      emit(UserFailureState());
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
      emit(UserFailureState());
    }
  }

  Future<void> _onFetchAccount(
      FetchAccountEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await _accountUseCase.getCurrentUser().then((res) => res.fold(
          // 세션 정보는 있으나, 유저 정보가 없는 경우 OnBoarding 페이지로
          (l) => emit(OnBoardingState(event.sessionUser)),
          // 세션 정보는 및 유저 정보가 있는 경우, Main 페이지로
          (r) => emit(
              UserLoadedState(sessionUser: event.sessionUser, account: r))));
    } catch (error) {
      log(error.toString());
      emit(UserFailureState());
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoadingState());
      await _authUseCase.signOut();
      emit(NotAuthenticatedState());
    } catch (error) {
      log(error.toString());
      emit(UserFailureState());
    }
  }
}
