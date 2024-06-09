part of '../../../module/user/account.usecase.dart';

class GetCurrentUserUseCase {
  final AccountRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<Either<Failure, AccountEntity>> call() async {
    return await _repository.getCurrentUser();
  }
}
