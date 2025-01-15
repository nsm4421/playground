part of '../export.datasource.dart';

abstract interface class AuthLocalDataSource {
  String? get token;

  Stream<String?> get tokenStream;

  void addData(String? accessToken);
}

abstract interface class AuthRemoteDataSource {
  Future<void> signUp({
    required String email,
    required String username,
    required String password,
    required String nickname,
    required File profileImage,
  });

  Future<String> signIn({required String username, required String password});

  Future<UserModel> getUser(String accessToken);
}
