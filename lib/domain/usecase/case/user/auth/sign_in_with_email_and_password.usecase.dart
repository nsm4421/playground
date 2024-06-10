part of '../../../module/user/auth.usecase.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignInWithEmailAndPasswordUseCase(this._repository);

  Future<Either<Failure, User?>> call(
      {required String email, required String password}) async {
    return await _repository.signInWithEmailAndPassword(
        email: email, password: password);
  }
}
