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
    emit(AuthLoadingState());
    await _authUseCase
        .signUpWithEmailAndPassword(
            email: event.email,
            password: event.password,
            nickname: event.nickname,
            profileUrl: event.profileUrl)
        .then((value) => value.fold(
            (l) => emit(AuthFailureState(l.message ?? 'sign up fail')),
            (r) => emit(AuthSuccessState(r))));
  }

  Future<void> _onSignInWithEmailAndPassword(
      SignInWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthLoadingState());
    await _authUseCase
        .signInWithEmailAndPassword(
            email: event.email, password: event.password)
        .then((res) {
      res.fold((l) => emit(AuthFailureState(l.message ?? 'sign in fail')),
          (r) => emit(AuthSuccessState(r)));
    });
  }

  Future<void> _onSignOut(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    await _authUseCase.signOut().then((value) => value.fold(
        (l) => emit(AuthFailureState(l.message ?? 'sign out fails')),
        (r) => emit(InitialAuthState())));
  }
}
