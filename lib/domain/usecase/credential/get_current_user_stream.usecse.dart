import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/domain/repository/user/credential.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetCurrentUserStreamUseCase {
  final CredentialRepository _repository;

  GetCurrentUserStreamUseCase(this._repository);

  Stream<User?> call() => _repository.currentUserStream;
}
