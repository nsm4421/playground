import 'package:injectable/injectable.dart';

import '../../repository/user/credential.repository.dart';

@singleton
class SignOutUseCase {
  final CredentialRepository _repository;

  SignOutUseCase(this._repository);

  Future<void> call() async => await _repository.signOut();
}
