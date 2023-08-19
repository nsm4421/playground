import 'package:chat_app/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
    Provider((ref) => AuthController(ref.watch(authRepositoryProvider)));

class AuthController {
  final AuthRepository authRepository;

  AuthController(this.authRepository);

  void sendSmsCode({
    required BuildContext context,
    required String phoneNumber,
  }) {
    authRepository.sendSmsCode(
      context: context,
      phoneNumber: phoneNumber,
    );
  }

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    authRepository.verifySmsCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: mounted);
  }
}
