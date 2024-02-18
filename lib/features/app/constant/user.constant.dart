import 'package:hot_place/features/app/constant/route.constant.dart';

enum UserStatus {
  online("접속중"),
  offline("미접속중"),
  dormant("휴면"),
  withdrawal("탈퇴");

  final String description;

  const UserStatus(this.description);
}

enum AuthStatus {
  authenticated,
  unAuthenticated;
}

enum SignUpStep {
  initial,
  phoneNumber,
  otp,
  onBoarding;
}
