import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/data/dto/user/user.dto.dart';
import 'package:uuid/uuid.dart';

class UserApi {
  UserApi({
    required FirebaseAuth auth,
    required FirebaseFirestore db,
  })  : _auth = auth,
        _db = db;

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  // 현재 로그인한 유저
  User? get currentUser => _auth.currentUser;

  // 현재 로그인한 유저의 uid
  String? get uid => _auth.currentUser?.uid;

  // 이메일, 비밀번호로 회원가입
  Future<UserCredential> createUserWithEmailAndPassword(
          {required String email, required String password}) async =>
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

  // 회원정보 저장
  // TODO : 비밀번호 encoding 후 저장
  Future<void> saveUserInfoInDB(UserDto dto) async =>
      await _db.collection('user').doc((const Uuid()).v1()).set(dto.toJson());

  // 이메일, 비밀번호로 로그인
  Future<UserCredential> signInWithEmailAndPassword(
          {required String email, required String password}) async =>
      await _auth.signInWithEmailAndPassword(email: email, password: password);
}
