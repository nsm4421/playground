import 'package:firebase_auth/firebase_auth.dart';

abstract class CredentialDataSource {
  String? get currentUid;

  Stream<User?> get currentUserStream;

  Future<void> signOut();

  Future<UserCredential> emailAndPasswordSignUp(
      {required String email, required String password});

  Future<UserCredential> emailAndPasswordSignIn(
      {required String email, required String password});

  Future<UserCredential> googleSignIn();
}
