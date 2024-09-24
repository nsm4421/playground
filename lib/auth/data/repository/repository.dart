part of 'repository_impl.dart';

abstract class AuthRepository {
  Future<ResponseWrapper<User?>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required String avatarUrl});

  Future<ResponseWrapper<User?>> signInWithEmailAndPassword(
      String email, String password);

  Future<ResponseWrapper<String>> uploadProfileImage(File profileImage);

  Future<ResponseWrapper<void>> signOut();

  Stream<User?> get userStream;

  User? get currentUser;

  Future<ResponseWrapper<void>> updateMetaData(
      {String? username, String? avatarUrl});
}
