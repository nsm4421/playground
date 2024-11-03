part of 'repository_impl.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl with CustomLogger implements AuthRepository {
  final AuthDataSource _authDataSource;
  final StorageDataSource _storageDataSource;

  AuthRepositoryImpl(
      {required AuthDataSource authDataSource,
      required StorageDataSource storageDataSource})
      : _authDataSource = authDataSource,
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
      logger.e(error);
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
      return Right(res);
    } on Exception catch (error) {
      logger.e(error);
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
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> signOut() async {
    try {
      await _authDataSource.signOut();
      return const Right(null);
    } on Exception catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  Future<String> _uploadImageAndReturnPublicUrl(File profileImage) async {
    return await _storageDataSource.uploadImageAndReturnPublicUrl(
        file: profileImage, bucketName: Buckets.avatars.name);
  }
}
