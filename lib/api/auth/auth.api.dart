import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_app/domain/dto/user/user.dto.dart';

class AuthApi {
  AuthApi(
      {required FirebaseAuth auth,
      required FirebaseFirestore db,
      required FirebaseStorage storage})
      : _auth = auth,
        _db = db,
        _storage = storage;

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  static const String _userCollectionName = 'user';

  /// login with email and password
  Future<UserCredential> signInWithEmailAndPassword(
          String email, String password) async =>
      await _auth.signInWithEmailAndPassword(email: email, password: password);

  /// register with email and password
  Future<UserCredential> createUserWithEmailAndPassword(
          String email, String password) async =>
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

  /// save user info in DB
  Future<void> saveUser(
          {required String uid,
          required String email,
          required String nickname}) async =>
      await _db
          .collection(_userCollectionName)
          .doc(uid)
          .set(UserDto(uid: uid, email: email, nickname: nickname).toJson());
}
