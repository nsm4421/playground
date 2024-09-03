part of '../usecase.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignUpWithEmailAndPasswordUseCase(this._repository);

  Future<void> call(String email, String password) async {
    await _repository.signUpWithEmailAndPassword(email, password);
  }
}
