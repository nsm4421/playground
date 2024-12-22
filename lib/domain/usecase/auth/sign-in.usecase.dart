part of '../export.usecase.dart';

class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<UserEntity>>> call(
      {required String email, required String password}) async {
    return await _repository.signIn(email: email, password: password);
  }
}
