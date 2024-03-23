import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/data/model/response/response.model.dart';
import 'package:hot_place/data/model/user/user.model.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../../../domain/repository/user/credential.repository.dart';
import '../../data_source/user/credential.data_source.dart';

@Singleton(as: CredentialRepository)
class CredentialRepositoryImpl extends CredentialRepository {
  final CredentialDataSource _credentialDataSource;
  final UserDataSource _userDataSource;
  final _logger = Logger();

  CredentialRepositoryImpl(
      {required CredentialDataSource credentialDataSource,
      required UserDataSource userDataSource})
      : _credentialDataSource = credentialDataSource,
        _userDataSource = userDataSource;

  @override
  bool get isAuthenticated => currentUid != null;

  @override
  String? get currentUid => _credentialDataSource.currentUid;

  @override
  Stream<User?> get currentUserStream =>
      _credentialDataSource.currentUserStream;

  @override
  Future<ResponseModel<void>> signOut() async {
    try {
      await _credentialDataSource.signOut();
      return ResponseModel<void>.success(data: null);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<void>.error();
    }
  }

  @override
  Future<ResponseModel<UserEntity>> googleSignIn() async {
    try {
      // fire auth로 구글 로그인
      final credential = await _credentialDataSource.googleSignIn();
      final user = UserEntity.fromCredential(credential);
      // 유저 DB 조회
      final fetched = await _userDataSource.findUserById(credential.user!.uid);
      // 기존에 유저 DB에 없는 경우, 유저 DB에 저장
      if (fetched == null) {
        await _userDataSource.insertUser(UserModel.fromCredential(credential));
      }
      return ResponseModel.success(data: user);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<UserEntity>.error();
    }
  }

  @override
  Future<ResponseModel<UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _credentialDataSource.emailAndPasswordSignIn(
          email: email, password: password);
      return ResponseModel<UserEntity>.success(
          data: UserEntity.fromCredential(credential));
    } catch (err) {
      _logger.e(err);
      return ResponseModel<UserEntity>.error();
    }
  }

  @override
  Future<ResponseModel<void>> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _credentialDataSource.emailAndPasswordSignUp(
          email: email, password: password);
      await _userDataSource.insertUser(UserModel.fromCredential(credential));
      return ResponseModel<void>.success(data: null);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<void>.error();
    }
  }
}
