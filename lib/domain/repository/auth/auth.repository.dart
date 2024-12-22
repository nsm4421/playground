part of '../export.repository.dart';

abstract class AuthRepository {
  Future<Either<ErrorResponse, SuccessResponse<UserEntity>>> getUser();

  Stream<UserEntity?> get authStream;

  Future<Either<ErrorResponse, SuccessResponse<void>>> signUp(
      {required String email,
      required String password,
      required String username});

  Future<Either<ErrorResponse, SuccessResponse<UserEntity>>> signIn(
      {required String email, required String password});

  Future<Either<ErrorResponse, SuccessResponse<void>>> signOut();
}
