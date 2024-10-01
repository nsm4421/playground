part of '../usecase.dart';

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<ResponseWrapper<void>> call() async {
    return await _repository.signOut();
  }
}
