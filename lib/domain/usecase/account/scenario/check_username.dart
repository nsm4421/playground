part of '../usecase.dart';

class CheckUsernameUseCase {
  final AccountRepository _repository;

  CheckUsernameUseCase(this._repository);

  Future<bool> call(String username) async =>
      await _repository.getIsUsernameDuplicated(username);
}
