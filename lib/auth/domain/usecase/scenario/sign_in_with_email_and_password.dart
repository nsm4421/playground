part of '../usecase.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignInWithEmailAndPasswordUseCase(this._repository);

  Future<User?> call(String email, String password) async {
    return await _repository.signInWithEmailAndPassword(email, password);
  }
}
