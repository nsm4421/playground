import 'package:hot_place/features/user/domain/repository/user.repository.dart';

class VerifyPhoneNumberUseCase {
  final UserRepository repository;

  VerifyPhoneNumberUseCase(this.repository);

  Future<void> call(String phoneNumber) async =>
      await repository.verifyPhoneNumber(phoneNumber);
}
