part of '../export.repository.dart';

abstract interface class AuthRepository {
  Future<Either<ErrorResponse, SuccessResponse<UserEntity>>> getCurrentUser();

  Stream<UserEntity?> get authStream;

  Future<Either<ErrorResponse, SuccessResponse<void>>> signUp({
    required String email,
    required String username,
    required String password,
    required String nickname,
    required File profileImage,
  });

  Future<Either<ErrorResponse, SuccessResponse<String>>> signIn(
      {required String username, required String password});

  Future<Either<ErrorResponse, SuccessResponse<void>>> signOut();
}
