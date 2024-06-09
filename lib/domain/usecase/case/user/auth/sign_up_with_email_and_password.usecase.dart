part of '../../../module/user/auth.usecase.dart';

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignUpWithEmailAndPasswordUseCase(this._repository);

  Future<Either<Failure, User?>> call(
      {required String email, required String password}) async {
    return await _repository.signUpWithEmailAndPassword(
        email: email, password: password);
  }
}
