part of '../usecase.dart';

class CheckUsernameUseCase {
  final AuthRepository _repository;

  CheckUsernameUseCase(this._repository);

  Future<bool> call(String username) async {
    return await _repository.checkUsername(username);
  }
}
