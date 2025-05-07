import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/data/dto/user/user.dto.dart';
import 'package:uuid/uuid.dart';

class AuthApi {
  AuthApi(
      {required FirebaseAuth auth,
      required FirebaseFirestore db,
      required FirebaseStorage storage})
      : _auth = auth,
        _db = db,
        _storage = storage;

  static const String _userCollectionName = "user";

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  // 현재 로그인한 유저
  User? get currentUser => _auth.currentUser;

  // 현재 로그인한 유저의 uid
  String? get uid => _auth.currentUser?.uid;

  // 인증 Stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // 이메일, 비밀번호로 회원가입
  Future<UserCredential> createUserWithEmailAndPassword(
          {required String email, required String password}) async =>
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

  // 회원정보 저장
  Future<void> saveUserInfoInDB(
          {required String uid, required UserDto dto}) async =>
      await _db.collection(_userCollectionName).doc(uid).set(dto.toJson());

  // 이메일, 비밀번호로 로그인
  Future<UserCredential> signInWithEmailAndPassword(
          {required String email, required String password}) async =>
      await _auth.signInWithEmailAndPassword(email: email, password: password);

  // 구글 계정으로 회원가입
  Future<UserCredential> signInWithGoogle() async {
    // 회원가입 처리 후 인증정보 추출
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    final userCredential = await _auth.signInWithCredential(credential);
    // 회원정보 저장
    final uid = userCredential.user?.uid ?? ((const Uuid()).v1());
    await _db.collection(_userCollectionName).doc(uid).set(UserDto(
          uid: uid,
          email: userCredential.user?.email ?? '',
          createdAt: DateTime.now(),
        ).toJson());
    return userCredential;
  }

  // 닉네임 중복여부
  Future<bool> checkNicknameDuplicated(String nickname) async {
    final count = (await _db
            .collection(_userCollectionName)
            .where("nickname", isEqualTo: nickname)
            .get())
        .docs
        .length;
    return count > 0;
  }

  // Email로 유저 조회
  Future<UserDto?> findByEmail(String email) async => await _db
      .collection(_userCollectionName)
      .where("email", isEqualTo: email)
      .get()
      .then((fetched) => fetched.size == 0
          ? null
          : UserDto.fromJson(fetched.docs.first.data()));

  // 프로필 이미지 저장 후, 다운로드 링크 반환
  Future<String> saveProfileImage(
          {required String uid,
          required String filename,
          required Uint8List imageData}) async =>
      await _storage
          .ref(_userCollectionName)
          .child(uid)
          .child(filename)
          .putData(imageData)
          .then((task) => task.ref.getDownloadURL());
}
