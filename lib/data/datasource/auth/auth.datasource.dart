import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthDataSource {}

abstract interface class RemoteAuthDataSource implements AuthDataSource {
  Stream<User?> get authStream;

  Future<void> signInWithGoogle();

  Future<void> signOut();
}

abstract interface class LocalAuthDataSource implements AuthDataSource {}
