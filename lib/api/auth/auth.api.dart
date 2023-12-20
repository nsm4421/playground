import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_app/domain/dto/user/user.dto.dart';
import 'package:uuid/uuid.dart';

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

  String? get currentUid => _auth.currentUser?.uid;

  Future<UserDto?> getCurrentUser() async => await _db
      .collection(_userCollectionName)
      .doc(_auth.currentUser?.uid)
      .get()
      .then((doc) => doc.data())
      .then((data) => data == null ? null : UserDto.fromJson(data));

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

  /// sign out
  Future<void> signOut() async => _auth.signOut();

  /// update user info
  Future<void> updateProfile(
      {required String nickname,
      required List<Uint8List> imageDataList}) async {
    // get user info in db
    final user = await getCurrentUser();
    if (user == null) {
      throw const CertificateException('to update profile, proceed login');
    }
    // save profile image in storage
    final profileImageUrls = await Future.wait(imageDataList.map(
        (imageData) async => await _storage
            .ref(_userCollectionName)
            .child(user.uid)
            .child('${(const Uuid()).v1()}.jpg')
            .putData(imageData)
            .then((task) => task.ref.getDownloadURL())));
    // save user info in DB
    await _db.collection(_userCollectionName).doc(user.uid).set(user
        .copyWith(nickname: nickname, profileImageUrls: profileImageUrls)
        .toJson());
  }
}
