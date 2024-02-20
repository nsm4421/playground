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

extension SignUpStepEx on SignUpStep {
  String get label {
    switch (this) {
      case SignUpStep.initial:
      case SignUpStep.phoneNumber:
        return "전화번호인증";
      case SignUpStep.otp:
        return "OTP인증";
      case SignUpStep.onBoarding:
        return "프로필 작성";
      default:
        return "ERROR";
    }
  }
}

class Profile {
  final String uid;
  final String? username;
  final String? profileImage;

  Profile({this.uid = "", this.username, this.profileImage});
}
