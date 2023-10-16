import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AuthRepository extends GetxService {
  static AuthRepository get to => Get.find();

  static Future<bool> get del => Get.delete<AuthRepository>();

  /// 특정 필드로 중복체크하기
  Future<bool> isDuplicated(String fieldName, String value) async =>
      (await FirebaseFirestore.instance
              .collection('user')
              .where(fieldName, isEqualTo: value)
              .get())
          .size
          .isGreaterThan(0);

  /// 이메일, 비밀번호로 회원가입하기
  Future<UserCredential?> createAccountWithEmailAndPassword(
          {required String email, required String password}) async =>
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

  /// 유저 정보 저장하기
  Future<void> saveDataInUserCollection(
          {required String uid, required Map<String, dynamic> data}) async =>
      await FirebaseFirestore.instance.collection('user').doc(uid).set(data);

  /// 유저 프로필 저장하기
  Future<String?> saveProfileImageInStorage(
      {required String uid, required File profileImage}) async {
    final ref =
        FirebaseStorage.instance.ref('user').child(uid).child('profile-image');
    final snapshot = await ref.putFile(profileImage);
    return await snapshot.ref.getDownloadURL();
  }

  /// 현재 로그인한 유저 정보
  User? getCurrentUser() => FirebaseAuth.instance.currentUser;
}
