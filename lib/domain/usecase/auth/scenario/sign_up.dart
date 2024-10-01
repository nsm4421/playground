part of '../usecase.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignUpWithEmailAndPasswordUseCase(this._repository);

  Future<ResponseWrapper<PresenceEntity?>> call(
      {required String email,
      required String password,
      required String username}) async {
    return await _repository.signUpWithEmailAndPassword(
        email: email, password: password, username: username);
  }
}
