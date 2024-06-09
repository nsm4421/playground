part of '../../../module/user/account.usecase.dart';

class CheckIsNicknameDuplicatedUseCase {
  final AccountRepository _repository;

  CheckIsNicknameDuplicatedUseCase(this._repository);

  Future<bool> call(String nickname) async =>
      await _repository.isDuplicatedNickname(nickname);
}
