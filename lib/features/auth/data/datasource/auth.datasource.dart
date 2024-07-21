part of "auth.datasource_impl.dart";

abstract interface class AuthDataSource {
  User? get currentUser;

  Stream<AuthState> get authStream;

  Future<User?> signUpWithEmailAndPassword(String email, String password);

  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut();
}
