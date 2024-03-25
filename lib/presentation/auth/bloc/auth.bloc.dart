import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/entity/user/user.entity.dart';
import '../../../domain/usecase/auth/sign_in_with_email_and_password.dart';
import '../../../domain/usecase/auth/sign_up_with_email_and_password.usecase.dart';

part 'auth.event.dart';

part 'auth.state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;
  final SignUpWithEmailAndPasswordUseCase _signUpWithEmailAndPasswordUseCase;

  AuthBloc(
      {required SignInWithEmailAndPasswordUseCase
          signInWithEmailAndPasswordUseCase,
      required SignUpWithEmailAndPasswordUseCase
          signUpWithEmailAndPasswordUseCase})
      : _signInWithEmailAndPasswordUseCase = signInWithEmailAndPasswordUseCase,
        _signUpWithEmailAndPasswordUseCase = signUpWithEmailAndPasswordUseCase,
        super(InitialAuthState()) {
    on<InitAuthEvent>(_onInit);
    on<SignUpWithEmailAndPasswordEvent>(_onSignUpWithEmailAndPassword);
    on<SignInWithEmailAndPasswordEvent>(_onSignInWithEmailAndPassword);
  }

  void _onInit(InitAuthEvent event, Emitter<AuthState> emit) {
    emit(InitialAuthState());
  }

  Future<void> _onSignUpWithEmailAndPassword(
      SignUpWithEmailAndPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    await _signUpWithEmailAndPasswordUseCase(
      email: event.email,
      password: event.password,
      nickname: event.nickname,
    ).then((value) => value.fold(
        (l) => emit(AuthFailureState(l.message ?? 'sign up fail')),
        (r) => emit(AuthSuccessState(r))));
  }

  Future<void> _onSignInWithEmailAndPassword(
      SignInWithEmailAndPasswordEvent event, Emitter<AuthState> emit) async {
    await _signInWithEmailAndPasswordUseCase(
            email: event.email, password: event.password)
        .then((value) => value.fold(
            (l) => emit(AuthFailureState(l.message ?? 'sign in fail')),
            (r) => emit(AuthSuccessState(r))));
  }
}
