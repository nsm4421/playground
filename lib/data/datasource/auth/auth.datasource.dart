import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthDataSource {}

abstract interface class RemoteAuthDataSource implements AuthDataSource {
  User? get currentUser;

  Stream<User?> get authStream;

  Future<User> signInWithGoogle();

  Future<void> signOut();
}

abstract interface class LocalAuthDataSource implements AuthDataSource {}
