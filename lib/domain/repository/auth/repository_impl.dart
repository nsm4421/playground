part of 'repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;
  final LocalDataSource _localDataSource;
  final StorageDataSource _storageDataSource;

  AuthRepositoryImpl(
      {required AuthDataSource authDataSource,
      required LocalDataSource localDataSource,
      required StorageDataSource storageDataSource})
      : _authDataSource = authDataSource,
        _localDataSource = localDataSource,
        _storageDataSource = storageDataSource;

  @override
  Stream<PresenceEntity?> get authStateStream =>
      _authDataSource.authStateStream.asyncMap(PresenceEntity.from);

  @override
  PresenceEntity? get currentUser =>
      PresenceEntity.from(_authDataSource.authUser);

  @override
  bool get isAuthorized => _authDataSource.isAuthorized;

  @override
  Future<Map<String, String?>> getEmailAndPassword() async {
    try {
      return await _localDataSource.getEmailAndPassword();
    } catch (error) {
      customUtil.logger.e(error);
      return {'email': null, 'password': null};
    }
  }

  @override
  Future<Either<ErrorResponse, PresenceEntity?>> editProfile(
      {String? username, File? profileImage}) async {
    try {
      if (username == null && profileImage == null) {
        throw Exception('nothing to update');
      }
      PresenceEntity? res;
      res = await _authDataSource
          .editProfile(username: username)
          .then(PresenceEntity.from);
      if (profileImage != null) {
        res = await _authDataSource
            .editProfile(
                avatarUrl: await _uploadImageAndReturnPublicUrl(profileImage))
            .then(PresenceEntity.from);
      }
      return Right(res);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, PresenceEntity?>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final res = await _authDataSource
          .signInWithEmailAndPassword(email: email, password: password)
          .then(PresenceEntity.from);
      await _localDataSource.saveEmailAndPassword(
          email, password); // 로컬DB에 인증정보 저장
      return Right(res);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, PresenceEntity?>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required File profileImage}) async {
    try {
      final avatarUrl = await _uploadImageAndReturnPublicUrl(profileImage);
      return await _authDataSource
          .signUpWithEmailAndPassword(
              email: email,
              password: password,
              username: username,
              avatarUrl: avatarUrl)
          .then(PresenceEntity.from)
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> signOut() async {
    try {
      await _authDataSource.signOut();
      await _localDataSource.deleteEmailAndPassword();
      return const Right(null);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  Future<String> _uploadImageAndReturnPublicUrl(File profileImage) async {
    return await _storageDataSource.uploadImageAndReturnPublicUrl(
        file: profileImage, bucketName: Buckets.avatar.name);
  }
}
