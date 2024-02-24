import 'package:hot_place/features/user/domain/entity/user/user.entity.dart';

abstract class UserRepository {
  // 로그인 여부 반환
  bool get isAuthorized;

  // 현재 로그인한 유저 id
  String? get currentUid;

  // 로그아웃
  Future<void> signOut();

  // 유저 데이터 생성
  Future<void> insertUser(UserEntity user);

  // 유저 데이터 수정
  Future<void> updateUser(UserEntity user);

  // 유저 목록 stream
  Stream<List<UserEntity>> get allUserStream;

  // 특정 유저 stream
  Stream<UserEntity> getUserStream(String uid);
}
