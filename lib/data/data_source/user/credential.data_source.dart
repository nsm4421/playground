import 'package:firebase_auth/firebase_auth.dart';

abstract class CredentialDataSource {
  String? get currentUid;

  Stream<User?> get currentUserStream;

  Future<void> signOut();

  Future<UserCredential> googleSignIn();
}
