import 'package:hot_place/core/constant/supbase.constant.dart';
import 'package:hot_place/data/data_source/auth/remote_data_source.dart';
import 'package:hot_place/domain/model/user/user.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/util/exeption.util.dart';

class RemoteAuthDataSourceImpl implements RemoteAuthDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemoteAuthDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Stream<AuthState> get authStream => _client.auth.onAuthStateChange;

  @override
  UserModel getCurrentUserOrElseThrow() {
    try {
      final session = _client.auth.currentSession;
      if (session == null) {
        throw const AuthException('세션정보가 null입니다');
      }
      return UserModel.fromSession(session.user);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final res = await _client.auth
          .signInWithPassword(email: email, password: password);
      final sessionUser = res.session?.user;
      if (sessionUser == null) {
        throw const AuthException('세션정보가 null입니다');
      }
      return UserModel.fromSession(sessionUser);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String nickname,
      required String profileUrl}) async {
    try {
      final res = await _client.auth.signUp(
          email: email, password: password, data: {"nickname": nickname});
      final sessionUser = res.user;
      if (sessionUser == null) {
        throw const AuthException('세션정보가 null임');
      }
      return UserModel.fromSession(sessionUser);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> insertUser(UserModel user) async {
    try {
      return await _client.rest.from(TableName.user.name).insert(user.toJson());
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> modifyUser(UserModel user) async {
    try {
      await _client.rest
          .from(TableName.user.name)
          .update(user.toJson())
          .eq('id', user.id);
      await _client.auth
          .updateUser(UserAttributes(data: {"nickname": user.nickname}));
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }
}
