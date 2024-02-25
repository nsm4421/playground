import 'package:injectable/injectable.dart';

import '../../repository/user/credential.repository.dart';

@singleton
class SignUpWithEmailAndPasswordUseCase {
  final CredentialRepository _repository;

  SignUpWithEmailAndPasswordUseCase(this._repository);

  Future<void> call({required String email, required String password}) async =>
      await _repository.signUpWithEmailAndPassword(
          email: email, password: password);
}
