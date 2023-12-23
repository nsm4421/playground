import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_app/core/constant/collection_name.enum.dart';
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

  String? get currentUid => _auth.currentUser?.uid;

  Stream<User?> get authStream => _auth.authStateChanges();

  Future<UserDto?> getCurrentUser() async => await _db
      .collection(CollectionName.user.name)
      .doc(_auth.currentUser?.uid)
      .get()
      .then((doc) => doc.data())
      .then((data) => data == null ? null : UserDto.fromJson(data));

  Future<String?> getNicknameByUid(String uid) async => await _db
      .collection(CollectionName.user.name)
      .doc(uid)
      .get()
      .then((doc) => doc.data())
      .then((data) => data == null ? null : UserDto.fromJson(data).nickname);

  /// login with email and password
  Future<UserCredential> signInWithEmailAndPassword(
          {required String email, required String password}) async =>
      await _auth.signInWithEmailAndPassword(email: email, password: password);

  /// register with email and password
  Future<UserCredential> createUserWithEmailAndPassword(
          {required String email, required String password}) async =>
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

  /// save user info in DB
  Future<void> saveUser(UserDto user) async => await _db
      .collection(CollectionName.user.name)
      .doc(user.uid)
      .set(user.toJson());

  /// sign out
  Future<void> signOut() async => _auth.signOut();

  /// save profile images in storage and return its download links
  Future<List<String>> saveProfileImages(
          {required String uid,
          required List<Uint8List> imageDataList}) async =>
      await Future.wait(imageDataList.map((imageData) async => await _storage
          .ref(CollectionName.user.name)
          .child(uid)
          .child('${(const Uuid()).v1()}.jpg')
          .putData(imageData)
          .then((task) => task.ref.getDownloadURL())));
}
