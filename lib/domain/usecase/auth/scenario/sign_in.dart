part of '../usecase.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignInWithEmailAndPasswordUseCase(this._repository);

  Future<Either<ErrorResponse, PresenceEntity?>> call(
      {required String email, required String password}) async {
    return await _repository
        .signInWithEmailAndPassword(email, password)
        .then((res) => res.mapLeft((l) => l.copyWith(
                message: switch (l.type) {
              ErrorType.invalidCredential => "credential is not valid",
              ErrorType.emailNotConfirmed =>
                "check confirm email sent to $email",
              ErrorType.userNotFound => "no user with email $email",
              ErrorType.inCorrectPassword => "password is wrong",
              ErrorType.accountDisabled => "current account is disabled",
              ErrorType.invalidExpiredToken => "token is expired",
              (_) => 'error occurs on login',
            })));
  }
}
