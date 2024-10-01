part of 'repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Stream<PresenceEntity?> get authStateStream =>
      _dataSource.authStateStream.asyncMap(PresenceEntity.from);

  @override
  PresenceEntity? get currentUser => PresenceEntity.from(_dataSource.authUser);

  @override
  bool get isAuthorized => _dataSource.isAuthorized;

  @override
  Future<ResponseWrapper<PresenceEntity?>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _dataSource
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
      required String username}) async {
    try {
      return await _dataSource
          .signInWithEmailAndPassword(email: email, password: password)
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
      return await _dataSource.signOut().then(ResponseSuccess<void>.from);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return ResponseError.from(error);
    }
  }
}
