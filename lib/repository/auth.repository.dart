import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:my_app/core/util/logger.dart';

class AuthRepository extends GetxService {
  static AuthRepository get to => Get.find();

  static Future<bool> get del => Get.delete<AuthRepository>();

  /// 이메일, 비밀번호로 회원가입하기
  Future<UserCredential?> createAccountWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      CustomLogger.logger.e(e);
      return null;
    }
  }

  /// 유저 정보 저장하기
  Future<bool> saveDataInUserCollection(
      {required String uid, required Map<String, dynamic> data}) async {
    try {
      await FirebaseFirestore.instance.collection('user').doc(uid).set(data);
      return true;
    } catch (e) {
      CustomLogger.logger.e(e);
      return false;
    }
  }

  /// 유저 프로필 저장하기
  Future<String?> saveProfileImageInStorage(
      {required String uid, required File profileImage}) async {
    try {
      final ref = FirebaseStorage.instance.ref('user').child('profile-image');
      final snapshot = await ref.putFile(profileImage);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      CustomLogger.logger.e(e);
      return null;
    }
  }

  /// 현재 로그인한 유저 정보
  User? getCurrentUser() => FirebaseAuth.instance.currentUser;
}
