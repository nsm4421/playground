import 'package:chat_app/common/routes/routes.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final authControllerProvider = Provider(
  (ref) => AuthController(
      authRepository: ref.watch(authRepositoryProvider), providerRef: ref),
);

final currentAuthProvider = FutureProvider(
  (ref) => ref.watch(authControllerProvider).getCurrentUser(),
);

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef providerRef;

  AuthController({required this.authRepository, required this.providerRef});

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

  saveUserInfoInFirestore({
    required String username,
    required XFile profileImage,
    required BuildContext context,
    required bool mounted,
  }) {
    // 프로필 정보 저장
    authRepository.saveUserInfoInFirestore(
        username: username,
        profileImage: profileImage,
        ref: providerRef,
        mounted: true);

    // Home화면으로 이동
    Navigator.pushNamedAndRemoveUntil(
      context,
      CustomRoutes.home,
      (route) => false,
    );
  }

  Future<UserModel?> getCurrentUser() async {
    return await authRepository.getCurrentUser();
  }
}
