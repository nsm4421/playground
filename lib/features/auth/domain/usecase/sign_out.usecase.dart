part of "auth.usecase_module.dart";

class SignOutUseCase {
  final AuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<ResponseWrapper<void>> call() async => await _repository.signOut();
}
