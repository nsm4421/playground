import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecase/module/auth/auth.usecase.dart';
import 'auth.state.dart';

@singleton
class AuthCubit extends Cubit<AuthenticationState> {
  final AuthUseCase _useCase;

  AuthCubit(this._useCase) : super(NotAuthenticatedState());

  User? get currentUser => _useCase.currentUser();

  Stream<User?> get authStream => _useCase.authStream();

  Future<void> signInWithGoogle() async {
    await _useCase.signInWithGoogle().then((res) => res.fold(
        (l) => emit(
            AuthFailureState(message: l.message ?? 'sign in request failed')),
        (r) => emit(AuthenticatedState(r))));
  }

  Future<void> signOut() async {
    await _useCase.signOut().then((res) => res.fold(
        (l) => emit(
            AuthFailureState(message: l.message ?? 'sign out request failed')),
        (r) => emit(NotAuthenticatedState())));
  }
}
