import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_app/core/constant/collection_name.enum.dart';
import 'package:my_app/domain/dto/user/user.dto.dart';
import 'package:uuid/uuid.dart';

import '../../domain/model/user/user.model.dart';

class UserApi {
  UserApi(
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

  Stream<UserModel> get currentUserStream => _db
      .collection(CollectionName.user.name)
      .doc(currentUid)
      .snapshots()
      .asyncMap((event) => UserDto.fromJson(event.data() ?? {}).toModel());

  Future<UserDto> findUserByUid(String uid) async => await _db
      .collection(CollectionName.user.name)
      .doc(uid)
      .get()
      .then((doc) => doc.data())
      .then((data) => UserDto.fromJson(data ?? {}));

  Future<UserDto?> getCurrentUser() async => await _db
      .collection(CollectionName.user.name)
      .doc(currentUid)
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

  /// search users by nickname
  Future<List<UserDto>> findUserByNickname(String keyword) => _db
      .collection(CollectionName.user.name)
      // like query
      .where(Filter.and(Filter('nickname', isGreaterThanOrEqualTo: keyword),
          Filter('nickname', isLessThan: '${keyword}z')))
      .get()
      .then((e) => e.docs
          .map((e) => e.data())
          .where((data) => data.isNotEmpty)
          .map((data) => UserDto.fromJson(data))
          .toList());

  /// add user id on followingUidList field
  Future<void> followUser(String opponentUid) async =>
      await _db.collection(CollectionName.user.name).doc(currentUid).update({
        'followingUidList': FieldValue.arrayUnion([opponentUid])
      });

  /// remove user id on followingUidList field
  Future<void> unFollowUser(String opponentUid) async =>
      await _db.collection(CollectionName.user.name).doc(currentUid).update({
        'followingUidList': FieldValue.arrayRemove([opponentUid])
      });

  /// get users stream that current user follows
  Stream<List<UserModel>> getFollowingStream() => _db
      .collection(CollectionName.user.name)
      .doc(currentUid)
      .snapshots()
      .asyncMap((event) async => await Future.wait(
          UserDto.fromJson(event.data() ?? {})
              .followingUidList
              .map((uid) async => (await findUserByUid(uid)).toModel())));

  /// get user stream that follows current user
  Stream<List<UserModel>> getFollowerStream() => _db
      .collection(CollectionName.user.name)
      .where('followingUidList', arrayContainsAny: [currentUid])
      .snapshots()
      .asyncMap((event) async => event.docs
          .map((doc) => doc.data() ?? {})
          .map((data) => UserDto.fromJson(data))
          .map((dto) => dto.toModel())
          .toList());
}
