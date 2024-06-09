part of 'account.datasource_impl.dart';

abstract interface class AccountDataSource {}

abstract interface class LocalAccountDataSource implements AccountDataSource {}

abstract interface class RemoteAccountDataSource implements AccountDataSource {
  Future<AccountModel> getCurrentUser();

  Future<void> upsertUser(AccountModel user);

  Future<void> deleteUser();

  /// on boarding
  Future<bool> isDuplicatedNickname(String nickname);

  String get profileImageUrl;

  Future<void> saveProfileImage(File image);
}
