part of 'package:portfolio/features/auth/data/repository_impl/auth.repository_impl.dart';

abstract interface class AuthRepository {
  User? get currentUser;

  Stream<AuthState> get authStream;

  Future<ResponseWrapper<User>> signUpWithEmailAndPassword(
      String email, String password);

  Future<ResponseWrapper<User>> signInWithEmailAndPassword(
      String email, String password);

  Future<ResponseWrapper<void>> signOut();

  Future<ResponseWrapper<void>> insertAccount(AccountEntity entity);

  Future<ResponseWrapper<User>> updateMetaData(
      {String? nickname, String? profileImage});

  Future<ResponseWrapper<void>> updateAccount(
      {required String uid, String? nickname, String? profileImage});

  Future<ResponseWrapper<String>> upsertProfileImage(
      {required String uid, required File profileImage});
}
