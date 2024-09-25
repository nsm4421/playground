import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/shared.export.dart';
import '../../domain/domain.export.dart';

part 'authentication.state.dart';

part 'authentication.event.dart';

@lazySingleton
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  late User? _currentUser;
  final AuthUseCase _useCase;

  AuthenticationBloc(this._useCase) : super(AuthenticationState()) {
    on<InitAuthEvent>(_onInit);
    on<AuthChangedEvent>(_onChange);
    on<SignInWithEmailAndPasswordEvent>(_onSignInWithEmailAndPassword);
    on<SignUpWithEmailAndPasswordEvent>(_onSignUpWithEmailAndPassword);
    on<SignOutEvent>(_onSignOut);
    on<UpdateProfileEvent>(_onUpdateProfile);
    _currentUser = _useCase.currentUser;
  }

  Stream<User?> get userStream => _useCase.userStream;

  User? get currentUser => _currentUser;

  PresenceEntity get presence => PresenceEntity.fromSupUser(currentUser!);

  _onInit(InitAuthEvent event, Emitter<AuthenticationState> emit) {
    final user = currentUser;
    if (user == null) {
      emit(state.copyWith(status: Status.initial));
      return;
    }
    // 자동로그인
    emit(state.copyWith(
        authStatus: AuthStatus.authenticated,
        status: Status.success,
        user: user,
        errorMessage: null));
  }

  _onChange(AuthChangedEvent event, Emitter<AuthenticationState> emit) {
    try {
      emit(state.copyWith(status: Status.loading));
      emit(AuthenticationState(
          authStatus: event.user == null
              ? AuthStatus.unAuthenticated
              : AuthStatus.authenticated,
          user: event.user,
          status: Status.success,
          errorMessage: null));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error));
    }
  }

  _onSignInWithEmailAndPassword(SignInWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.signInWithEmailAndPassword
          .call(event.email, event.password)
          .then((res) => res.ok
              ? emit(state.copyWith(
                  authStatus: AuthStatus.authenticated,
                  user: res.data,
                  status: Status.success,
                  errorMessage: null))
              : emit(state.copyWith(
                  status: Status.error, errorMessage: res.message)));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error, errorMessage: '로그인 중 오류 발생'));
    }
  }

  _onSignUpWithEmailAndPassword(SignUpWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.signUpWithEmailAndPassword
          .call(
              email: event.email,
              password: event.password,
              username: event.username,
              profileImage: event.profileImage)
          .then((res) => res.ok
              ? emit(state.copyWith(
                  authStatus: AuthStatus.authenticated,
                  user: res.data,
                  status: Status.success,
                  errorMessage: null))
              : emit(state.copyWith(
                  status: Status.error, errorMessage: res.message)));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error));
    }
  }

  _onSignOut(SignOutEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.signOut().then((res) => res.ok
          ? emit(AuthenticationState(
              authStatus: AuthStatus.unAuthenticated,
              user: null,
              status: Status.success,
              errorMessage: null))
          : state.copyWith(status: Status.error, errorMessage: res.message));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error));
    }
  }

  _onUpdateProfile(
      UpdateProfileEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: Status.success, user: currentUser));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, errorMessage: '프로필 업데이트 중 오류 발생'));
    }
  }
}
