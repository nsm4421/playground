part of 'datasource_impl.dart';

abstract class AuthDataSource {
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String avatarUrl,
  });

  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut();

  Stream<AuthState> get authStream;

  User? get currentUser;

  Future<void> updateMetaData({
    String? username,
    String? avatarUrl,
  });
}
