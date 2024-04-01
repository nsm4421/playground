import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/usecase/auth/get_auth_stream.usecase.dart';
import 'package:hot_place/domain/usecase/auth/get_current_user.usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/entity/user/user.entity.dart';
import '../../../domain/usecase/auth/sign_in_with_email_and_password.dart';
import '../../../domain/usecase/auth/sign_out.usecase.dart';
import '../../../domain/usecase/auth/sign_up_with_email_and_password.usecase.dart';

part 'auth.event.dart';

part 'auth.state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthenticationState> {
  final GetAuthStreamUseCase _getAuthStreamUseCase;
  final GetCurrentUserUserCase _getCurrentUserUserCase;
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;
  final SignUpWithEmailAndPasswordUseCase _signUpWithEmailAndPasswordUseCase;
  final SignOutUseCase _signOutUseCase;

  AuthBloc(
      {required GetAuthStreamUseCase getAuthStreamUseCase,
      required GetCurrentUserUserCase getCurrentUserUserCase,
      required SignInWithEmailAndPasswordUseCase
          signInWithEmailAndPasswordUseCase,
      required SignUpWithEmailAndPasswordUseCase
          signUpWithEmailAndPasswordUseCase,
      required SignOutUseCase signOutUseCase})
      : _getAuthStreamUseCase = getAuthStreamUseCase,
        _getCurrentUserUserCase = getCurrentUserUserCase,
        _signInWithEmailAndPasswordUseCase = signInWithEmailAndPasswordUseCase,
        _signUpWithEmailAndPasswordUseCase = signUpWithEmailAndPasswordUseCase,
        _signOutUseCase = signOutUseCase,
        super(InitialAuthState()) {
    on<InitAuthEvent>(_onInit);
    on<UpdateCurrentUserEvent>(_onUpdateCurrentUser);
    on<SignUpWithEmailAndPasswordEvent>(_onSignUpWithEmailAndPassword);
    on<SignInWithEmailAndPasswordEvent>(_onSignInWithEmailAndPassword);
    on<SignOutEvent>(_onSignOut);
  }

  Stream<AuthState> get authStream => _getAuthStreamUseCase();

  UserEntity? get currentUser =>
      _getCurrentUserUserCase().fold((l) => null, (r) => r);

  bool get isAuthenticated =>
      _getCurrentUserUserCase().fold((l) => false, (r) => true);

  void _onInit(InitAuthEvent event, Emitter<AuthenticationState> emit) {
    emit(InitialAuthState());
  }

  Future<void> _onUpdateCurrentUser(
      UpdateCurrentUserEvent event, Emitter<AuthenticationState> emit) async {
    _getCurrentUserUserCase().fold(
        (l) => emit(InitialAuthState()), (r) => emit(AuthSuccessState(r)));
  }

  Future<void> _onSignUpWithEmailAndPassword(
      SignUpWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    emit(AuthLoadingState());
    await _signUpWithEmailAndPasswordUseCase(
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
    await _signInWithEmailAndPasswordUseCase(
            email: event.email, password: event.password)
        .then((value) => value.fold(
            (l) => emit(AuthFailureState(l.message ?? 'sign in fail')),
            (r) => emit(AuthSuccessState(r))));
  }

  Future<void> _onSignOut(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    await _signOutUseCase().then((value) => value.fold(
        (l) => emit(AuthFailureState(l.message ?? 'sign out fails')),
        (r) => emit(InitialAuthState())));
  }
}
