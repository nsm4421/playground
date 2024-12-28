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

  // 로컬 스토리지에 토큰이 상태가 변경될 때마다 서버로부터 유저정보를 다시 가져오는 Stream
  @override
  Stream<UserEntity?> get authStream =>
      _localDataSource.tokenStream.asyncMap((token) async {
        try {
          logger.d('token:$token');
          return token == null
              ? null
              : await _remoteDataSource.getUser(token).then(UserEntity.from);
        } catch (error) {
          logger.e(error);
          return null;
        }
      });

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> signUp({
    required String email,
    required String username,
    required String nickname,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signUp(
        email: email,
        username: username,
        nickname: nickname,
        password: password,
      );
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<String>>> signIn(
      {required String username, required String password}) async {
    try {
      // 서버에 인증정보를 보내 토큰 발급받기
      final accessToken = await _remoteDataSource.signIn(
          username: username, password: password);

      // 발급된 토큰을 로컬 스토리지에 저장
      await _localDataSource.saveToken(accessToken);
      return Right(SuccessResponse(payload: accessToken));
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<UserEntity>>>
      getCurrentUser() async {
    try {
      // 로컬 스토리지에서 토큰 찾기
      final accessToken = await _localDataSource.getToken();
      if (accessToken == null) {
        return Left(ErrorResponse(
            code: StatusCode.invalidCredential, message: 'no token is given'));
      }
      // 토큰을 사용해 서버로부터 유저정보 가져오기
      final user = await _remoteDataSource.getUser(accessToken);
      return Right(SuccessResponse(payload: UserEntity.from(user)));
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> signOut() async {
    try {
      // 로컬 스토리지에서 토큰 지우기
      await _localDataSource.deleteToken();
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }
}
