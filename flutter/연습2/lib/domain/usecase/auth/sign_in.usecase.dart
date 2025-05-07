part of '../export.usecase.dart';

class SignInUseCase {
  final AuthRepository _repository;

  SignInUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<UserEntity>>> call(
      {required String username, required String password}) async {
    // 토큰을 가져오기
    final getTokenRes =
        await _repository.signIn(username: username, password: password);
    if (getTokenRes.isLeft) {
      return Left(getTokenRes.left);
    }
    // 현재 유저 가져오기
    return await _repository.getCurrentUser();
  }
}
