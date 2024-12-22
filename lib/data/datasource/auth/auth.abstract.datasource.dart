part of '../export.datasource.dart';

abstract class AuthLocalDataSource {
  Stream<UserModel?> get authStream;

  Future<UserModel?> get();

  Future<void> save(UserModel model);

  Future<void> delete();
}

abstract class AuthRemoteDataSource {
  Future<void> signUp(
      {required String email,
      required String password,
      required String username});

  Future<UserModel> signIn({required String email, required String password});
}
