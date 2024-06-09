part of '../../../module/user/auth.usecase.dart';

class SignInWithGoogleUseCase {
  final AuthRepository _repository;

  SignInWithGoogleUseCase(this._repository);

  Future<Either<Failure, User?>> call() async {
    return await _repository.signInWithGoogle();
  }
}
