part of '../usecase.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignInWithEmailAndPasswordUseCase(this._repository);

  Future<ResponseWrapper<User?>> call(String email, String password) async {
    final res = await _repository.signInWithEmailAndPassword(email, password);
    return res.ok
        ? SuccessResponse<User?>(data: res.data, message: '로그인에 성공하였습니다')
        : ErrorResponse<User?>(data: res.data, message: '로그인에 실패하였습니다');
  }
}
