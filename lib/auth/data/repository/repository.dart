part of 'repository_impl.dart';

abstract class AuthRepository {
  Future<RepositoryResponseWrapper<User?>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String avatarUrl});

  Future<RepositoryResponseWrapper<User?>> signInWithEmailAndPassword(
      String email, String password);

  Future<RepositoryResponseWrapper<bool>> checkUsername(String username);

  Future<RepositoryResponseWrapper<String>> uploadProfileImage(File profileImage);

  Future<RepositoryResponseWrapper<void>> signOut();

  Stream<User?> get userStream;

  User? get currentUser;
}
