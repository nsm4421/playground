part of 'user.datasource_impl.dart';

abstract interface class UserDataSource {}

abstract interface class LocalUserDataSource implements UserDataSource {}

abstract interface class RemoteUserDataSource implements UserDataSource {
  Future<UserModel> getCurrentUser();

  Future<void> upsertUser(UserModel user);

  Future<void> deleteUser();

  /// on boarding
  Future<bool> checkIsDuplicatedNickname(String nickname);

  Future<String> getProfileImageDownloadUrl();

  Future<void> saveProfileImage(File image);
}
