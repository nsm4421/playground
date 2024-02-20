abstract class SignUpEvent {}

class SignUpInit extends SignUpEvent {}

class ToPhoneNumber extends SignUpInit {}

class VerifyPhoneNumber extends SignUpEvent {
  final String phoneNumber;

  VerifyPhoneNumber(this.phoneNumber);
}

class VerifyOtpCode extends SignUpEvent {}
