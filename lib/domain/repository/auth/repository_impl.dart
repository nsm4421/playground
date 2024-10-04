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
  Future<ResponseWrapper<PresenceEntity?>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _authDataSource
          .signInWithEmailAndPassword(email: email, password: password)
          .then(PresenceEntity.from)
          .then(ResponseSuccess<PresenceEntity?>.from);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return ResponseError.from(error);
    }
  }

  @override
  Future<ResponseWrapper<PresenceEntity?>> signUpWithEmailAndPassword(
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
          .then(ResponseSuccess<PresenceEntity?>.from);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return ResponseError.from(error);
    }
  }

  @override
  Future<ResponseWrapper<void>> signOut() async {
    try {
      return await _authDataSource.signOut().then(ResponseSuccess<void>.from);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return ResponseError.from(error);
    }
  }
}
