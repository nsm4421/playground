part of "auth.usecase_module.dart";

class GetAuthStreamUseCase {
  final AuthRepository _repository;

  GetAuthStreamUseCase(this._repository);

  Stream<AuthState> call() => _repository.authStream;
}

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  User? call() => _repository.currentUser;
}

class SignUpWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignUpWithEmailAndPasswordUseCase(this._repository);

  Future<ResponseWrapper<User>> call(String email, String password) async =>
      await _repository.signUpWithEmailAndPassword(email, password);
}

class SignInWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignInWithEmailAndPasswordUseCase(this._repository);

  Future<ResponseWrapper<User>> call(String email, String password) async =>
      await _repository.signInWithEmailAndPassword(email, password);
}

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<ResponseWrapper<void>> call() async => await _repository.signOut();
}
