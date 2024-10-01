import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/domain/entity/auth/presence.dart';

import '../../../core/constant/constant.dart';
import '../../../domain/usecase/auth/usecase.dart';

part 'authentication.state.dart';

part 'authentication.event.dart';

@lazySingleton
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthUseCase _useCase;

  AuthenticationBloc(this._useCase) : super(AuthenticationState()) {
    on<UpdateCurrentUserEvent>(_onUpdate);
    on<SignUpWithEmailAndPasswordEvent>(_onSignUp);
    on<SignInWithEmailAndPasswordEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
  }

  Stream<PresenceEntity?> get authStateStream =>
      _useCase.authStateStream.call();

  Future<void> _onUpdate(
      UpdateCurrentUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(state
        .copyWith(isAuthorized: event.presence?.uid != null)
        .copyWithCurrentUser(event.presence));
  }

  Future<void> _onSignUp(SignUpWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    final res = await _useCase.signUp(
        email: event.email, password: event.password, username: event.username);
    if (res.ok) {
      emit(state
          .copyWith(status: Status.success, isAuthorized: true)
          .copyWithCurrentUser(res.data));
    } else {
      emit(state
          .copyWith(
              status: Status.error,
              isAuthorized: false,
              errorMessage: 'error occurs on sign up')
          .copyWithCurrentUser(null));
    }
  }

  Future<void> _onSignIn(SignInWithEmailAndPasswordEvent event,
      Emitter<AuthenticationState> emit) async {
    final res =
        await _useCase.signIn(email: event.email, password: event.password);
    if (res.ok) {
      emit(state
          .copyWith(status: Status.success, isAuthorized: true)
          .copyWithCurrentUser(res.data));
    } else {
      emit(state
          .copyWith(
              status: Status.error,
              isAuthorized: false,
              errorMessage: 'error occurs on sign in')
          .copyWithCurrentUser(null));
    }
  }

  Future<void> _onSignOut(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    final res = await _useCase.signOut();
    if (res.ok) {
      emit(state
          .copyWith(status: Status.success, isAuthorized: false)
          .copyWithCurrentUser(null));
    } else {
      emit(state.copyWith(
          status: Status.error, errorMessage: 'error occurs on sign out'));
    }
  }
}
