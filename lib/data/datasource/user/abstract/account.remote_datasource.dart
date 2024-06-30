part of '../impl/account.remote_datasource_impl.dart';

abstract interface class RemoteAccountDataSource {
  Future<AccountDto> getCurrentUser();

  Future<AccountDto> findByUserId(String userId);

  Future<void> upsertUser(AccountDto user);

  Future<void> deleteUser();

  /// on boarding
  Future<bool> isDuplicatedNickname(String nickname);

  String get profileImageUrl;

  Future<void> saveProfileImage(File image);
}
