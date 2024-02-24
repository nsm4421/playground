import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../repository/user/credential.repository.dart';

@singleton
class GoogleSignInUseCase {
  final CredentialRepository _repository;

  GoogleSignInUseCase(this._repository);

  Future<UserCredential> call() async => await _repository.googleSignIn();
}
