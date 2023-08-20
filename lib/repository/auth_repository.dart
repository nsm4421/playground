import 'package:chat_app/common/routes/routes.dart';
import 'package:chat_app/common/widget/w_show_dialog.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/repository/firesbase_storage_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRepository({required this.firebaseAuth, required this.firebaseFirestore});

  void sendSmsCode({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await firebaseAuth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            showAlertDialogWidget(context: context, message: e.toString());
          },
          codeSent: (smsCodeId, resendCodeId) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                CustomRoutes.verifyNumber, (route) => false, arguments: {
              'phoneNumber': phoneNumber,
              'smsCodeId': smsCodeId
            });
          },
          codeAutoRetrievalTimeout: (String smsCodeId) {});
    } on FirebaseAuth catch (e) {
      showAlertDialogWidget(context: context, message: e.toString());
    }
  }

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: smsCodeId,
        smsCode: smsCode,
      );
      await firebaseAuth.signInWithCredential(credential);
      if (!mounted) return;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(CustomRoutes.addUserInfo, (route) => false);
    } on FirebaseAuth catch (e) {}
  }

  void saveUserInfoInFirestore({
    required String username,
    required String profileImage,
    required ProviderRef ref,
    required bool mounted,
  }) async {
    try {
      User? currentUser = firebaseAuth.currentUser;
      if (currentUser == null) return;
      if (currentUser.phoneNumber == null) return;

      // 프로필 이미지가 있는 경우
      // if (profileImage != null) {
      //   String? profileImageDownloadLink = await ref
      //       .read(firebaseStoreageRepositoryProvider)
      //       .saveFile(ref: '/profile/${currentUser.uid}', file: profileImage);
      // }

      UserModel user = UserModel(
          username: username,
          uid: currentUser.uid,
          profileImageUrl: '',
          active: true,
          phoneNumber: currentUser.phoneNumber!,
          groupId: []);

      await firebaseFirestore
          .collection('users')
          .doc(currentUser.uid)
          .set(user.toMap());
      if (!mounted) return;
    } catch (e) {}
  }
}
