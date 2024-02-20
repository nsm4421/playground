import 'package:hot_place/features/user/domain/entity/contact/contact.entity.dart';
import 'package:hot_place/features/user/domain/entity/user/user.entity.dart';

abstract class UserRepository {
  // 전화번호 인증
  Future<void> verifyPhoneNumber(String phoneNumber);

  // 회원가입
  Future<void> verifyOtpNumber(String otpCode);

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

  // 연락처 가져오기
  Future<List<ContactEntity>> getDeviceNumber();
}
