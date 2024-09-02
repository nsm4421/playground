part of '../usecase.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignInWithEmailAndPasswordUseCase(this._repository);

  Future<void> call(String email, String password) async {
    await _repository.signUpWithEmailAndPassword(email, password);
  }
}
