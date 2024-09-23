part of '../usecase.dart';

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<ResponseWrapper<void>> call() async {
    final res = await _repository.signOut();
    return res.ok
        ? const SuccessResponse<void>(message: '로그아웃되었습니다')
        : const ErrorResponse<void>(message: '로그아웃에 실패하였습니다');
  }
}
