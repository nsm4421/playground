part of '../../../module/user/account.usecase.dart';

class UpsertUserUseCase {
  final AccountRepository _repository;

  UpsertUserUseCase(this._repository);

  Future<Either<Failure, void>> call(AccountEntity entity) async {
    return await _repository.upsertUser(entity);
  }
}
