import 'dart:io';

import 'package:logger/logger.dart';
import 'package:my_app/core/constant/supabase.constant.dart';
import 'package:my_app/domain/model/user/account.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exception/custom_exception.dart';

part 'account.datasource.dart';

class LocalAccountDataSourceImpl implements LocalAccountDataSource {}

class RemoteAccountDataSourceImpl implements RemoteAccountDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemoteAccountDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Future<AccountModel> getCurrentUser() async {
    try {
      final fetched = await _client.rest
          .from(TableName.user.name)
          .select("*")
          .eq('id', _getCurrentUidOrElseThrow)
          .limit(1);
      if (fetched.isEmpty) {
        throw const AuthException('user not found from database');
      } else {
        return AccountModel.fromJson(fetched[0]);
      }
    } catch (error) {
      throw CustomException.from(error,
          logger: _logger, message: 'user not found from database');
    }
  }

  @override
  Future<void> upsertUser(AccountModel user) async =>
      throw UnimplementedError();

  @override
  Future<void> deleteUser() async => throw UnimplementedError();

  @override
  Future<bool> checkIsDuplicatedNickname(String nickname) async =>
      throw UnimplementedError();

  @override
  Future<String> getProfileImageDownloadUrl() async =>
      throw UnimplementedError();

  @override
  Future<void> saveProfileImage(File image) async => throw UnimplementedError();

  String get _getCurrentUidOrElseThrow {
    final currentUid = _client.auth.currentUser?.id;
    if (currentUid == null) {
      throw const AuthException('NOT LOGIN');
    }
    return currentUid;
  }
}
