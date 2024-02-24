import 'package:hot_place/features/user/domain/entity/user/user.entity.dart';
import 'package:hot_place/features/user/domain/repository/user.repository.dart';
import 'package:injectable/injectable.dart';

import '../data_source/base/user.data_source.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl(this.userDataSource);

  @override
  Future<void> insertUser(UserEntity user) async =>
      await userDataSource.insertUser(user.toModel());

  @override
  Future<void> updateUser(UserEntity user) async =>
      await userDataSource.updateUser(user.toModel());

  @override
  Stream<List<UserEntity>> get allUserStream => userDataSource.allUserStream;

  @override
  Stream<UserEntity> getUserStream(String uid) =>
      userDataSource.getUserStream(uid);
}
