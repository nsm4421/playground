import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/domain/repository/user/user.repository.dart';
import 'package:injectable/injectable.dart';

import '../../repository/user/credential.repository.dart';

@singleton
class GoogleSignUpUseCase {
  final CredentialRepository credentialRepository;

  GoogleSignUpUseCase({required this.credentialRepository});

  Future<UserCredential> call() async =>
      await credentialRepository.googleSignIn();
}
