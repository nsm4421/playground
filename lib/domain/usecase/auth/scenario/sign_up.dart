part of '../usecase.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignUpWithEmailAndPasswordUseCase(this._repository);

  Future<Either<ErrorResponse, PresenceEntity?>> call(
      {required String email,
      required String password,
      required String username,
      required File profileImage}) async {
    return await _repository
        .signUpWithEmailAndPassword(
            email: email,
            password: password,
            username: username,
            profileImage: profileImage)
        .then((res) => res.mapLeft((l) => l.copyWith(
                message: switch (l.type) {
              ErrorType.userAlreadyExist => "$email already exist",
              ErrorType.invalidFormat => "email is not valid",
              ErrorType.toWeekPassword => "password is too weak",
              (_) => 'error occurs on sign up',
            })));
  }
}
