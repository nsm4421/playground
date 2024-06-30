part of '../impl/auth.remote_datasource_impl.dart';

abstract interface class RemoteAuthDataSource {
  User? get currentUser;

  Stream<AuthState> get authStream;

  Future<User?> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<User?> signInWithGoogle();

  Future<void> signOut();
}
