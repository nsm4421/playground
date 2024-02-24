import 'package:hot_place/features/user/domain/entity/user/user.entity.dart';

abstract class UserRepository {
  // 유저 데이터 생성
  Future<void> insertUser(UserEntity user);

  // 유저 데이터 수정
  Future<void> updateUser(UserEntity user);

  // 유저 목록 stream
  Stream<List<UserEntity>> get allUserStream;

  // 특정 유저 stream
  Stream<UserEntity> getUserStream(String uid);
}
