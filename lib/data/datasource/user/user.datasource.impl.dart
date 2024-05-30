import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:my_app/data/datasource/user/user.datasource.dart';
import 'package:my_app/domain/model/user/user.model.dart';

import '../../../core/constant/error_code.dart';
import '../../../core/exception/custom_exeption.dart';

class LocalUserDataSourceImpl implements LocalUserDataSource {}

class RemoteUserDataSourceImpl implements RemoteUserDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final Logger _logger;

  static const colName = "users";

  RemoteUserDataSourceImpl(
      {required FirebaseAuth auth,
      required FirebaseFirestore db,
      required Logger logger})
      : _auth = auth,
        _db = db,
        _logger = logger;

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final currentUid = _auth.currentUser?.uid;
      if (currentUid == null) {
        throw CustomException(
            errorCode: ErrorCode.authError, message: 'not logined');
      }
      final json = await _db
          .collection(colName)
          .doc(currentUid)
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
      if (user.id.isEmpty) {
        throw ArgumentError('uid is not valid');
      }
      await _db.collection(colName).doc(user.id).set(user.toJson());
    } catch (error) {
      throw CustomException.from(error,
          logger: _logger, message: 'upsert user request fail');
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      final currentUid = _auth.currentUser?.uid;
      if (currentUid == null) {
        throw CustomException(
            errorCode: ErrorCode.authError, message: 'uid is not valid');
      }
      await _db.collection(colName).doc(currentUid).delete();
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }
}
