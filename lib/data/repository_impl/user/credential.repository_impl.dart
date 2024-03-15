import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/data/data_source/user/user.data_source.dart';
import 'package:hot_place/data/model/response/response.model.dart';
import 'package:hot_place/data/model/user/user.model.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../../../core/constant/response.constant.dart';
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
      return ResponseModel<void>.fromResponseType(
          responseType: ResponseType.ok);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<void>.fromResponseType(
          responseType: ResponseType.internalError);
    }
  }

  @override
  Future<ResponseModel<UserEntity>> googleSignIn() async {
    try {
      final credential = await _credentialDataSource.googleSignIn();
      final uid = credential.user?.uid;
      UserModel user = await _userDataSource.findUserById(uid!);
      if (user.uid.isEmpty) {
        user = UserEntity.fromCredential(credential).toModel();
        await _userDataSource.insertUser(user);
      }
      return ResponseModel<UserEntity>.fromResponseType(
          responseType: ResponseType.ok, data: UserEntity.fromModel(user));
    } catch (err) {
      _logger.e(err);
      return ResponseModel<UserEntity>.fromResponseType(
          responseType: ResponseType.internalError);
    }
  }

  @override
  Future<ResponseModel<UserEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _credentialDataSource.emailAndPasswordSignIn(
          email: email, password: password);
      final user = await _userDataSource.findUserById(credential.user!.uid);
      return ResponseModel<UserEntity>.fromResponseType(
          responseType: ResponseType.ok, data: UserEntity.fromModel(user));
    } catch (err) {
      _logger.e(err);
      return ResponseModel<UserEntity>.fromResponseType(
          responseType: ResponseType.internalError);
    }
  }

  @override
  Future<ResponseModel<void>> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await _credentialDataSource.emailAndPasswordSignUp(
          email: email, password: password);
      final user = UserEntity.fromCredential(credential).toModel();
      await _userDataSource.insertUser(user);
      return ResponseModel<void>.fromResponseType(
          responseType: ResponseType.ok);
    } catch (err) {
      _logger.e(err);
      return ResponseModel<void>.fromResponseType(
          responseType: ResponseType.internalError);
    }
  }
}
