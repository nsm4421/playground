import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:my_app/data/datasource/user/user.datasource.dart';
import 'package:my_app/domain/model/user/user.model.dart';

import '../../../core/constant/error_code.dart';
import '../../../core/exception/custom_exeption.dart';

class LocalUserDataSourceImpl implements LocalUserDataSource {}

class RemoteUserDataSourceImpl implements RemoteUserDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;
  final Logger _logger;

  static const colName = "users";
  static const bucketName = "users";

  RemoteUserDataSourceImpl(
      {required FirebaseAuth auth,
      required FirebaseFirestore db,
      required FirebaseStorage storage,
      required Logger logger})
      : _auth = auth,
        _db = db,
        _storage = storage,
        _logger = logger;

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final json = await _db
          .collection(colName)
          .doc(_auth.currentUser!.uid)
          .get()
          .then((res) => res.data());
      if (json == null) {
        throw CustomException(
            errorCode: ErrorCode.firebaseNotFound, message: 'user not found');
      }
      return UserModel.fromJson(json);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> upsertUser(UserModel user) async {
    try {
      await _db
          .collection(colName)
          .doc(_auth.currentUser!.uid)
          .set(user.copyWith(id: _auth.currentUser!.uid).toJson());
    } catch (error) {
      throw CustomException.from(error,
          logger: _logger, message: 'upsert user request fail');
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      await _db.collection(colName).doc(_auth.currentUser?.uid).delete();
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<bool> checkIsDuplicatedNickname(String nickname) async {
    try {
      final QuerySnapshot snapshot = await _db
          .collection(colName)
          .where('nickname', isEqualTo: nickname)
          .limit(1)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<String> getProfileImageDownloadUrl() async {
    try {
      final ref = _storage.ref('profile_image/${_auth.currentUser!.uid}.jpg');
      return await ref.getDownloadURL();
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveProfileImage(File image) async {
    try {
      final ref = _storage.ref('profile_image/${_auth.currentUser!.uid}.jpg');
      await ref.putFile(image);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }
}
