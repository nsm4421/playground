part of '../export.repository_impl.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl with LoggerUtil implements AuthRepository {
  final AuthLocalDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(
      {required AuthLocalDataSource localDataSource,
      required AuthRemoteDataSource remoteDataSource})
      : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Stream<UserEntity?> get authStream => _localDataSource.authStream
      .asyncMap((item) => item == null ? null : UserEntity.from(item));

  @override
  Future<Either<ErrorResponse, SuccessResponse<UserEntity>>> getUser() async {
    try {
      final fetched = await _localDataSource.get();
      if (fetched == null) {
        return Left(ErrorResponse(code: StatusCode.notFound));
      }
      return Right(SuccessResponse(payload: UserEntity.from(fetched)));
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<UserEntity>>> signIn(
      {required String email, required String password}) async {
    try {
      final user =
          await _remoteDataSource.signIn(email: email, password: password);
      await _localDataSource.save(user);
      return Right(SuccessResponse(payload: UserEntity.from(user)));
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> signOut() async {
    try {
      await _localDataSource.delete();
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> signUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      await _remoteDataSource.signUp(
          email: email, password: password, username: username);
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }
}
