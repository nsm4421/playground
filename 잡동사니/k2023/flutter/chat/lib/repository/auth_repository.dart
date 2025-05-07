import 'dart:typed_data';

import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/utils/image_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    storage: FirebaseStorage.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseStorage _storage;
  final FirebaseFirestore _firestore;

  AuthRepository({
    required FirebaseAuth auth,
    required FirebaseStorage storage,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _storage = storage,
        _firestore = firestore;

  /// Uid로 유저 조회하기
  Future<UserModel> getUserInfoByUid(String uid) async => await _firestore
      .collection('users')
      .where('uid', isEqualTo: uid)
      .get()
      .then((snapshot) => snapshot.docs.first)
      .then((doc) => UserModel.fromJson(doc.data()));

  /// 프로필 이미지 저장하기
  /// @params imageData 프로필 이미지
  /// @return 다운로드 링크 (future)
  Future<String?> saveProfileImageInStorage(
      {required String uid, required XFile xFile}) async {
    try {
      final storageRef = _storage.ref().child('users').child('thumbnail');
      final compressedImage =
          await ImageUtils.imageCompress(img: await xFile.readAsBytes());
      await storageRef.putData(compressedImage);
      return await storageRef.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  /// 구글 계정으로 회원가입하기
  Future<UserCredential> signUpWithGoogle() async => await GoogleSignIn()
      .signIn()
      .then((googleUser) async => await googleUser?.authentication)
      .then((auth) => GoogleAuthProvider.credential(
          accessToken: auth?.accessToken, idToken: auth?.idToken))
      .then((credential) async => await _auth.signInWithCredential(credential));

  /// 이메일, 비밀번호로 회원가입하기
  Future<UserCredential> signUpWithEmailAndPassword(
          String email, String password) async =>
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  /// 이메일, 비밀번호로 로그인하기
  Future<UserCredential> loginWithEmailAndPassword(
          String email, String password) async =>
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  /// 회원가입된 유저 정보를 Firestore에 저장하기
  Future<bool> saveUserInDB(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid!).set(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 현재 로그인한 유저 가져오기
  User? getCurrentUser() => _auth.currentUser;

  /// 닉네임 중복여부
  Future<bool> isUsernameDuplicated(String username) async =>
      (await _firestore
          .collection('users')
          .where("username", isEqualTo: username)
          .get()
          .then((value) => value.size)) >
      0;
}
