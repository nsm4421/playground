part of 'datasource_impl.dart';

abstract class AccountDataSource {
  Future<bool> checkUsername(String username);

  Future<void> updateAccount({String? username, String? avatarUrl});
}
