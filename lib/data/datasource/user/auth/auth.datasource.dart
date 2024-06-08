part of 'auth.datasource_impl.dart';

abstract interface class AuthDataSource {}

abstract interface class RemoteAuthDataSource implements AuthDataSource {
  User? get currentUser;

  Stream<AuthState> get authStream;

  Future<User> signInWithGoogle();

  Future<void> signOut();
}

abstract interface class LocalAuthDataSource implements AuthDataSource {}
