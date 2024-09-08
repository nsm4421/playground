part of '../usecase.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignInWithEmailAndPasswordUseCase(this._repository);

  Future<UseCaseResponseWrapper<User?>> call(
      String email, String password) async {
    return await _repository
        .signInWithEmailAndPassword(email, password)
        .then((res) => UseCaseResponseWrapper.from(res,
            successMessage: '로그인에 성공하였습니다',
            // TODO : 인증오류별로 다른 메세지 뿌리기
            errorMessage: '로그인에 실패하였습니다'));
  }
}
