part of 'repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
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
  Future<Either<ErrorResponse, PresenceEntity?>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _authDataSource
          .signInWithEmailAndPassword(email: email, password: password)
          .then(PresenceEntity.from)
          .then(Right.new);
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
      final avatarUrl = await _storageDataSource.uploadImageAndReturnPublicUrl(
          file: profileImage, bucketName: 'avatar');
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
      return await _authDataSource.signOut().then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }
}
