import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/usecase/auth/auth.usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/entity/user/user.entity.dart';

part 'auth.event.dart';

part 'auth.state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthenticationState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase) : super(InitialAuthState()) {
    on<InitAuthEvent>(_onInit);
    on<UpdateCurrentUserEvent>(_onUpdateCurrentUser);
    on<SignUpWithEmailAndPasswordEvent>(_onSignUpWithEmailAndPassword);
    on<SignInWithEmailAndPasswordEvent>(_onSignInWithEmailAndPassword);
    on<SignOutEvent>(_onSignOut);
  }

  Stream<AuthState> get authStream => _authUseCase.getAuthStream();

  UserEntity? get currentUser =>
      _authUseCase.getCurrentUser().fold((l) => null, (r) => r);

  bool get isAuthenticated =>
      _authUseCase.getCurrentUser().fold((l) => false, (r) => true);

  void _onInit(InitAuthEvent event, Emitter<AuthenticationState> emit) {
    emit(InitialAuthState());
  }

  Future<void> _onUpdateCurrentUser(
      UpdateCurrentUserEvent event, Emitter<AuthenticationState> emit) async {
    _authUseCase.getCurrentUser().fold(
        (l) => emit(InitialAuthState()), (r) => emit(AuthSuccessState(r)));
  }

  Future<void> _onSignUpWithEmailAndPassword(
      SignUpWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    try {
      emit(AuthLoadingState());
      await _authUseCase
          .signUpWithEmailAndPassword(
              email: event.email,
              password: event.password,
              nickname: event.nickname,
              profileUrl: event.profileUrl)
          .then((value) => value.fold(
              (l) => emit(AuthFailureState(l.message ?? '회원가입에 실패하였습니다')),
              (r) => emit(AuthSuccessState(r))));
    } catch (err) {
      emit(const AuthFailureState('회원가입에 실패하였습니다'));
      debugPrint(err.toString());
    }
  }

  Future<void> _onSignInWithEmailAndPassword(
      SignInWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    // 로그인
    try {
      emit(AuthLoadingState());
      await _authUseCase
          .signInWithEmailAndPassword(
              email: event.email, password: event.password)
          .then((res) {
        res.fold((l) => emit(AuthFailureState(l.message ?? '로그인에 실패하였습니다')),
            (r) => emit(AuthSuccessState(r)));
      });
    } catch (err) {
      emit(const AuthFailureState('로그인에 실패하였습니다'));
      debugPrint(err.toString());
    }
  }

  Future<void> _onSignOut(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    try {
      await _authUseCase.signOut().then((value) => value.fold(
          (l) => emit(AuthFailureState(l.message ?? '로그아웃에 실패하였습니다')),
          (r) => emit(InitialAuthState())));
    } catch (err) {
      emit(const AuthFailureState('로그아웃에 실패하였습니다'));
      debugPrint(err.toString());
    }
  }
}
