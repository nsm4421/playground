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
  final AuthUseCase _useCase;

  AuthenticationBloc(this._useCase) : super(AuthenticationState()) {
    on<InitAuthEvent>(_onInit);
    on<AuthChangedEvent>(_onChange);
    on<CheckUsernameEvent>(_onCheckUsername);
    on<SignInWithEmailAndPasswordEvent>(_onSignInWithEmailAndPassword);
    on<SignUpWithEmailAndPasswordEvent>(_onSignUpWithEmailAndPassword);
    on<SignOutEvent>(_onSignOut);
  }

  Stream<User?> get userStream => _useCase.userStream;

  User? get currentUser => _useCase.currentUser;

  _onInit(InitAuthEvent event, Emitter<AuthenticationState> emit) {
    emit(state.copyWith(status: Status.initial));
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

  _onCheckUsername(
      CheckUsernameEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.checkUsername.call(event.username).then((res) => res.fold(
          onSuccess: (_) => emit(state.copyWith(status: Status.initial)),
          onError: (message) => emit(state.copyWith(errorMessage: message))));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(
          status: Status.error, errorMessage: '유저명 중복체크 중 오류 발생'));
    }
  }

  _onSignInWithEmailAndPassword(SignInWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.signInWithEmailAndPassword
          .call(event.email, event.password)
          .then((res) => res.fold(
              onSuccess: (data) => emit(state.copyWith(
                  authStatus: AuthStatus.authenticated,
                  user: res.data,
                  status: Status.success,
                  errorMessage: null)),
              onError: (message) => emit(state.copyWith(
                  status: Status.error, errorMessage: message))));
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
          .then((res) => res.fold(
              onSuccess: (data) => emit(state.copyWith(
                  authStatus: AuthStatus.authenticated,
                  user: data,
                  status: Status.success,
                  errorMessage: null)),
              onError: (message) => emit(state.copyWith(
                  status: Status.error, errorMessage: message))));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error));
    }
  }

  _onSignOut(SignOutEvent event, Emitter<AuthenticationState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.signOut().then((res) => res.fold(
          onSuccess: (_) => emit(AuthenticationState(
              authStatus: AuthStatus.unAuthenticated,
              user: null,
              status: Status.success,
              errorMessage: null)),
          onError: (message) => emit(
              state.copyWith(status: Status.error, errorMessage: message))));
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error));
    }
  }
}
