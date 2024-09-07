part of '../usecase.dart';

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<void> call() async {
    return await _repository.signOut();
  }
}
