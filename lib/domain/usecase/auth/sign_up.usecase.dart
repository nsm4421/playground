part of '../export.usecase.dart';

class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<void>>> call({
    required String email,
    required String password,
    required String username,
    required String nickname,
    required File profileImage,
  }) async {
    return await _repository.signUp(
      email: email,
      password: password,
      username: username,
      nickname: nickname,
      profileImage: profileImage,
    );
  }
}
