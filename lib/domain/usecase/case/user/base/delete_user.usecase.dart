part of '../../../module/user/user.usecase.dart';

class DeleteUserUseCase {
  final AccountRepository _repository;

  DeleteUserUseCase(this._repository);

  Future<Either<Failure, void>> call() async {
    return await _repository.deleteUser();
  }
}
