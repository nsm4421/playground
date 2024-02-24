import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/features/user/domain/repository/user.repository.dart';
import 'package:injectable/injectable.dart';

import '../../repository/credential.repository.dart';

@singleton
class GoogleSignUpUseCase {
  final UserRepository userRepository;
  final CredentialRepository credentialRepository;

  GoogleSignUpUseCase(
      {required this.userRepository, required this.credentialRepository});

  Future<UserCredential> call() async =>
      await credentialRepository.googleSignIn();
}
