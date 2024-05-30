import 'package:my_app/domain/model/user/user.model.dart';

abstract interface class UserDataSource {}

abstract interface class LocalUserDataSource implements UserDataSource {}

abstract interface class RemoteUserDataSource implements UserDataSource {
  Future<UserModel> getCurrentUser();

  Future<void> upsertUser(UserModel user);

  Future<void> deleteUser();
}
