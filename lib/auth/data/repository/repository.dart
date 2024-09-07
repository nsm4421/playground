part of 'repository_impl.dart';

abstract class AuthRepository {
  Future<User?> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String avatarUrl});

  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<bool> checkUsername(String username);

  Future<String> uploadProfileImage(File profileImage);

  Future<void> signOut();

  Stream<User?> get userStream;

  User? get currenetUser;
}
