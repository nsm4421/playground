import 'package:injectable/injectable.dart';

import '../../repository/user/credential.repository.dart';

@singleton
class SignOutUseCase {
  final CredentialRepository repository;

  SignOutUseCase(this.repository);

  Future<void> call() async => await repository.signOut();
}
