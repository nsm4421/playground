import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/features/user/domain/repository/credential.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetCurrentUserStreamUseCase {
  final CredentialRepository repository;

  GetCurrentUserStreamUseCase(this.repository);

  Stream<User?> call() => repository.currentUserStream;
}
