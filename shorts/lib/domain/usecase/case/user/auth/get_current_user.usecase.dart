part of '../../../module/user/auth.usecase.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  User? call() => _repository.currentUser;
}
