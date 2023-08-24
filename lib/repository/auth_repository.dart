import 'dart:io';

import 'package:chat_app/common/routes/routes.dart';
import 'package:chat_app/common/widget/w_show_dialog.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/repository/firesbase_storage_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance),
);

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

  Future<bool> isSavingUserInfoSuccess({
    required String username,
    required XFile profileImage,
    required ProviderRef ref,
    required bool mounted,
  }) async {
    try {
      User? currentUser = firebaseAuth.currentUser;
      if (currentUser == null) return false;
      if (currentUser.phoneNumber == null) return false;

      bool isUsernameDuplicated = await firebaseFirestore
          .collection('users')
          .doc(username)
          .get()
          .then((DocumentSnapshot snapshot) => snapshot.exists);
      if (isUsernameDuplicated) return false;

      // 프로필 이미지가 있는 경우
      String? profileImageDownloadLink = await ref
          .read(firebaseStoreageRepositoryProvider)
          .saveFile(
              ref: '/profile/${currentUser.uid}',
              file: File(profileImage.path));

      UserModel user = UserModel(
          username: username,
          uid: currentUser.uid,
          profileImageUrl: profileImageDownloadLink ?? '',
          active: true,
          phoneNumber: currentUser.phoneNumber!,
          groupId: []);

      // DB에 저장
      await firebaseFirestore
          .collection('users')
          .doc(currentUser.uid)
          .set(user.toMap());
      if (!mounted) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel?> getCurrentUser() async {
    UserModel? currentUser;
    final data = (await firebaseFirestore
            .collection('users')
            .doc(firebaseAuth.currentUser?.uid)
            .get())
        .data();
    if (data != null) currentUser = UserModel.fromJson(data);
    return currentUser;
  }
}
