part of "auth.usecase_module.dart";

class SignInWithEmailAndPasswordUseCase {
  final AuthRepository _repository;

  SignInWithEmailAndPasswordUseCase(this._repository);

  Future<ResponseWrapper<User>> call(String email, String password) async =>
      await _repository.signInWithEmailAndPassword(email, password);
}
