import 'package:hot_place/features/user/domain/repository/user.repository.dart';

class SignInWithPhoneNumberUseCase {
  final UserRepository repository;

  SignInWithPhoneNumberUseCase(this.repository);

  Future<void> call(String otpCode) async =>await
      repository.verifyOtpNumber(otpCode);
}
