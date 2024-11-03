part of '../usecase.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignUpWithEmailAndPasswordUseCase(this._repository);

  Future<Either<ErrorResponse, PresenceEntity?>> call(
      {required String email,
      required String password,
      required String username,
      required File profileImage}) async {
    return await _repository.signUpWithEmailAndPassword(
        email: email,
        password: password,
        username: username,
        profileImage: profileImage);
  }
}
