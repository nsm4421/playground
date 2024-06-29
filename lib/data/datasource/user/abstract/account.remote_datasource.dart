part of '../impl/account.remote_datasource_impl.dart';

abstract interface class RemoteAccountDataSource {
  Future<AccountModel> getCurrentUser();

  Future<AccountModel> findByUserId(String userId);

  Future<void> upsertUser(AccountModel user);

  Future<void> deleteUser();

  /// on boarding
  Future<bool> isDuplicatedNickname(String nickname);

  String get profileImageUrl;

  Future<void> saveProfileImage(File image);
}
