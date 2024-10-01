part of '../usecase.dart';

class GetAuthStateStreamUseCase {
  final AuthRepository _repository;

  GetAuthStateStreamUseCase(this._repository);

  Stream<PresenceEntity?> call() => _repository.authStateStream;
}

class GetIsAuthorizedUseCase {
  final AuthRepository _repository;

  GetIsAuthorizedUseCase(this._repository);

  bool call() => _repository.isAuthorized;
}

class GetCurrentUser {
  final AuthRepository _repository;

  GetCurrentUser(this._repository);

  PresenceEntity? call() => _repository.currentUser;
}
