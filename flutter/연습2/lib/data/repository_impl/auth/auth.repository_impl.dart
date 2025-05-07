part of '../export.repository_impl.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl with LoggerUtil implements AuthRepository {
  static const _key = "access_token"; // 로컬 스토리지에서 토큰을 저장할 키값

  final AuthLocalDataSource _authLocalDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;
  final StorageLocalDataSource _storageLocalDataSource;
  final SocketRemoteDataSource _socketRemoteDataSource;

  AuthRepositoryImpl({
    required AuthLocalDataSource authLocalDataSource,
    required AuthRemoteDataSource authRemoteDataSource,
    required StorageLocalDataSource storageLocalDataSource,
    required SocketRemoteDataSource socketRemoteDataSource,
  })  : _authLocalDataSource = authLocalDataSource,
        _authRemoteDataSource = authRemoteDataSource,
        _storageLocalDataSource = storageLocalDataSource,
        _socketRemoteDataSource = socketRemoteDataSource;

  // 로컬 스토리지에 토큰이 상태가 변경될 때마다 서버로부터 유저정보를 다시 가져오는 Stream
  @override
  Stream<UserEntity?> get authStream =>
      _authLocalDataSource.tokenStream.asyncMap((token) async {
        try {
          return token == null
              ? null
              : await _authRemoteDataSource
                  .getUser(token)
                  .then(UserEntity.from);
        } catch (error) {
          logger.e(error);
          return null;
        }
      });

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> signUp({
    required String email,
    required String username,
    required String password,
    required String nickname,
    required File profileImage,
  }) async {
    try {
      return await _authRemoteDataSource
          .signUp(
            email: email,
            username: username,
            password: password,
            nickname: nickname,
            profileImage: profileImage,
          )
          .then((res) => SuccessResponse(payload: null))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<String>>> signIn(
      {required String username, required String password}) async {
    try {
      // 서버에 인증정보를 보내 토큰 발급받기
      final accessToken = await _authRemoteDataSource.signIn(
          username: username, password: password);

      // 발급받은 토큰 로컬 스토리지에 저장
      await _storageLocalDataSource
          .save(key: _key, value: accessToken)
          .then((_) {
        // 저장 성공 시 스트림에 데이터 추가
        _authLocalDataSource.addData(accessToken);
      });

      return Right(SuccessResponse(payload: accessToken));
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<UserEntity>>>
      getCurrentUser() async {
    try {
      // 로컬 스토리지에서 토큰 찾기
      final accessToken = await _storageLocalDataSource.get(_key);
      if (accessToken == null) {
        // 토큰 정보가 없는 경우 로그아웃 처리
        _authLocalDataSource.addData(null);
        return Left(ErrorResponse(
            code: StatusCode.invalidCredential, message: 'no token is given'));
      }
      // 토큰을 사용해 서버로부터 유저정보 가져오기
      final user = await _authRemoteDataSource.getUser(accessToken);
      _authLocalDataSource.addData(accessToken);
      return Right(SuccessResponse(payload: UserEntity.from(user)));
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> signOut() async {
    try {
      return await _storageLocalDataSource
          .delete(_key) // 로컬 스토리지에서 토큰 지우기
          .then((_) {
            // 로그아웃 처리
            _authLocalDataSource.addData(null);
          })
          .then((_) => SuccessResponse(payload: null))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> editProfile(
      {required String nickname, File? profileImage}) async {
    try {
      return await _authRemoteDataSource
          .editProfile(nickname: nickname, profileImage: profileImage)
          .then((_) => SuccessResponse(payload: null))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  void initSocket() {
    _socketRemoteDataSource.init(_authLocalDataSource.token!);
  }
}
