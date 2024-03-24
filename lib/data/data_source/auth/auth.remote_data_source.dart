import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/auth/auth.data_source.dart';
import 'package:hot_place/domain/model/user/user.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteAuthDataSource extends AuthDataSource {
  final SupabaseClient _client;

  RemoteAuthDataSource(this._client);

  final _logger = Logger();

  GoTrueClient get _auth => _client.auth;

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
    // TODO : 닉네임 중복여부
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
}
