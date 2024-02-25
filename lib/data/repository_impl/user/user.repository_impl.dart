import 'package:hot_place/domain/entity/user/user.entity.dart';
import 'package:hot_place/domain/repository/user/user.repository.dart';
import 'package:injectable/injectable.dart';

import '../../data_source/user/user.data_source.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final UserDataSource _userDataSource;

  UserRepositoryImpl(this._userDataSource);

  @override
  Future<void> insertUser(UserEntity user) async =>
      await _userDataSource.insertUser(user.toModel());

  @override
  Future<void> updateUser(UserEntity user) async =>
      await _userDataSource.updateUser(user.toModel());

  @override
  Stream<List<UserEntity>> get allUserStream => _userDataSource.allUserStream;

  @override
  Stream<UserEntity> getUserStream(String uid) =>
      _userDataSource.getUserStream(uid);
}
