import 'dart:io';

import 'package:logger/logger.dart';
import 'package:my_app/domain/model/user/account.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  Future<AccountModel> getCurrentUser() async => throw UnimplementedError();

  @override
  Future<void> upsertUser(AccountModel user) async => throw UnimplementedError();

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
}
