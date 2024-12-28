part of '../export.datasource.dart';

abstract interface class AuthLocalDataSource {
  Stream<String?> get tokenStream;

  Future<String?> getToken();

  Future<void> saveToken(String accessToken);

  Future<void> deleteToken();
}

abstract interface class AuthRemoteDataSource {
  Future<void> signUp({
    required String email,
    required String username,
    required String password,
    required String nickname,
  });

  Future<String> signIn({required String username, required String password});

  Future<UserModel> getUser(String accessToken);
}
