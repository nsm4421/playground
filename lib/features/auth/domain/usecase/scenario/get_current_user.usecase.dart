part of "../auth.usecase_module.dart";

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  User? call() => _repository.currentUser;
}