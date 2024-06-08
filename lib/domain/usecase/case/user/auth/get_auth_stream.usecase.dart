part of '../../../module/user/auth.usecase.dart';

class GetAuthStreamUseCase {
  final AuthRepository _repository;

  GetAuthStreamUseCase(this._repository);

  Stream<AuthState> call() => _repository.authStream;
}
