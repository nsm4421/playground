import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecase/module/auth.usecase.dart';

part 'auth.state.dart';

part "auth.event.dart";

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthUseCase _useCase;

  AuthenticationBloc(this._useCase) : super(NotAuthenticatedState()) {
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignOutEvent>(_onSignOut);
  }

  Stream<User?> get authStream => _useCase.authStream();

  Future<void> _onSignInWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthenticationState> emit) async {
    await _useCase.signInWithGoogle().then((res) => res.fold(
        (l) => emit(
            AuthFailureState(message: l.message ?? 'sign in request failed')),
        (r) => emit(AuthenticatedState())));
  }

  Future<void> _onSignOut(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    await _useCase.signOut().then((res) => res.fold(
        (l) => emit(
            AuthFailureState(message: l.message ?? 'sign out request failed')),
        (r) => emit(NotAuthenticatedState())));
  }
}
