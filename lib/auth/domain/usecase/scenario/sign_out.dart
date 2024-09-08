part of '../usecase.dart';

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<UseCaseResponseWrapper<void>> call() async {
    return await _repository.signOut().then((res) =>
        UseCaseResponseWrapper.from(res,
            successMessage: '로그아웃되었습니다', errorMessage: '로그아웃에 실패하였습니다'));
  }
}
