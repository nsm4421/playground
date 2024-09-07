part of 'datasource_impl.dart';

abstract class AuthDataSource {
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
    required String avatarUrl,
  });
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<bool> checkUsername(String username);
  Future<String> uploadProfileImage(File profileImage);
  Future<void> signOut();
  Stream<AuthState> get authStream;
  User? get currentUser;
}
