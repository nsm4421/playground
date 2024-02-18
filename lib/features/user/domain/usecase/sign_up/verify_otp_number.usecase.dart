import 'package:hot_place/features/user/domain/repository/user.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class VerifyOtpNumber {
  final UserRepository repository;

  VerifyOtpNumber(this.repository);

  Future<void> call(String otpCode) async =>await
      repository.verifyOtpNumber(otpCode);
}
