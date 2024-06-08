import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/constant/error_code.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../data/entity/user/account.entity.dart';
import '../../../../domain/usecase/module/user/auth.usecase.dart';
import '../../../../domain/usecase/module/user/user.usecase.dart';

part "account.event.dart";

part "account.state.dart";

@singleton
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AuthUseCase _authUseCase;
  final UserUseCase _userUseCase;

  AccountBloc(
      {required AuthUseCase authUseCase, required UserUseCase userUseCase})
      : _authUseCase = authUseCase,
        _userUseCase = userUseCase,
        super(NotSignInState()) {
    on<InitAccountEvent>(_onInit);
    on<SignInEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
    on<InitOnBoardingEvent>(_onInitOnBoarding);
    on<OnBoardingEvent>(_onOnBoarding);
  }

  Future<void> _onInit(
      InitAccountEvent event, Emitter<AccountState> emit) async {
    final sessionUser = _authUseCase.currentUser();
    // 로그인 하지 않은 경우
    if (sessionUser == null) {
      emit(NotSignInState());
      return;
    }
    // 로그인한 경우
    final res = await _userUseCase.getCurrentUser();
    res.fold((l) {
      if (l.code == ErrorCode.notSignIn) {
        emit(InitialOnBoardingState(sessionUser));
      } else {
        emit(UserFailureState(sessionUser, message: l.message));
      }
    }, (r) {
      emit(UserLoadedState(sessionUser, r));
    });
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AccountState> emit) async {
    final res = await _userUseCase.getCurrentUser();
    res.fold((l) {
      if (l.code == ErrorCode.notSignIn) {
        emit(InitialOnBoardingState(event.user));
      } else {
        emit(UserFailureState(event.user, message: l.message));
      }
    }, (r) {
      emit(UserLoadedState(event.user, r));
    });
  }

  Future<void> _onSignOut(
      SignOutEvent event, Emitter<AccountState> emit) async {
    emit(NotSignInState());
  }

  Future<void> _onInitOnBoarding(
      InitOnBoardingEvent event, Emitter<AccountState> emit) async {
    emit(InitialOnBoardingState(event.sessionUser));
  }

  Future<void> _onOnBoarding(
      OnBoardingEvent event, Emitter<AccountState> emit) async {
    emit(OnBoardingLoadingState(event.sessionUser));
    final res = await _userUseCase.onBoarding(
        sessionUser: event.sessionUser,
        nickname: event.nickname,
        image: event.image,
        description: event.description);
    res.fold(
        (l) =>
            emit(OnBoardingFailureState(event.sessionUser, message: l.message)),
        (r) => emit(UserLoadedState(event.sessionUser, r)));
  }
}
