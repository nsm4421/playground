import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/auth/auth.data_source.dart';
import 'package:hot_place/domain/model/user/user.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteAuthDataSource extends AuthDataSource {
  final GoTrueClient _auth;
  final PostgrestClient _db;

  RemoteAuthDataSource(
      {required GoTrueClient auth, required PostgrestClient db})
      : _auth = auth,
        _db = db;

  final _logger = Logger();

  @override
  Stream<AuthState> get authStream => _auth.onAuthStateChange;

  @override
  UserModel getCurrentUserOrElseThrow() {
    try {
      final session = _auth.currentSession;
      if (session == null) {
        throw CustomException(
            code: ErrorCode.unAuthorized, message: 'session not exists');
      }

      return UserModel.fromSession(session.user);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.serverRequestFail,
          message: 'error occurs on getting session');
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final res =
          await _auth.signInWithPassword(email: email, password: password);
      final sessionUser = res.session?.user;
      if (sessionUser == null) {
        throw CustomException(
            code: ErrorCode.serverRequestFail,
            message:
                'session user not created after email and password sign in');
      }
      return UserModel.fromSession(sessionUser);
    } on AuthException catch (err) {
      // supbase 인증오류인경우
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.serverRequestFail, message: err.message);
    } catch (err) {
      // 그 외 에러
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.internalServerError,
          message:
              'internal server error occurs on email and password sign in');
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String nickname}) async {
    try {
      final res = await _auth.signUp(
          email: email, password: password, data: {'nickname': nickname});
      final sessionUser = res.user;
      if (sessionUser == null) {
        throw CustomException(
            code: ErrorCode.serverRequestFail,
            message:
                'session user not created after email and password sign up');
      }
      return UserModel.fromSession(sessionUser);
    } on AuthException catch (err) {
      // supbase 인증오류인경우
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.serverRequestFail, message: err.message);
    } catch (err) {
      // 그 외 에러
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.internalServerError,
          message:
              'internal server error occurs on email and password sign up');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on AuthException catch (err) {
      // supbase 인증오류인경우
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.serverRequestFail, message: err.message);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.internalServerError,
          message: 'internal server error occurs on sign out');
    }
  }

  @override
  Future<void> insertUser(UserModel user) async {
    try {
      return await _db.from(Tables.user.name).insert(user.toJson());
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.internalServerError, message: 'insert user fails');
    }
  }

  @override
  Future<void> modifyUser(UserModel user) async {
    try {
      await _db.from(Tables.user.name).update(user.toJson()).eq('id', user.id);
    } catch (err) {
      _logger.e(err);
      throw CustomException(
          code: ErrorCode.internalServerError, message: 'insert user fails');
    }
  }
}
