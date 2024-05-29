part of '../../module/auth.usecase.dart';

class SignInWithGoogleUseCase {
  final AuthRepository _repository;

  SignInWithGoogleUseCase(this._repository);

  Future<Either<Failure, void>> call() async {
    return await _repository.signInWithGoogle();
  }
}
