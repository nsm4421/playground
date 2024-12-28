part of '../export.usecase.dart';

class GetUserUseCase {
  final AuthRepository _repository;

  GetUserUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<UserEntity>>> call() async {
    return await _repository.getCurrentUser();
  }
}
