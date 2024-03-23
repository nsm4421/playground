import 'package:hot_place/domain/entity/user/user.entity.dart';

import '../../model/user/user.model.dart';

abstract class UserDataSource {
  Future<UserModel?> findUserById(String uid);

  Future<void> insertUser(UserModel user);

  Future<void> updateUser(UserModel user);

  Stream<List<UserEntity>> get allUserStream;

  Stream<UserEntity> getUserStream(String uid);
}
