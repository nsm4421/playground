import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:my_app/core/constant/firebase.dart';
import 'package:my_app/core/exception/custom_exeption.dart';
import 'package:my_app/data/datasource/short/short.datasource.dart';
import 'package:my_app/domain/model/short/short.model.dart';

import '../../../core/constant/error_code.dart';

class LocalShortDataSourceImpl implements LocalShortDataSource {}

class RemoteShortDataSourceImpl implements RemoteShortDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;
  final Logger _logger;

  static const orderBy = "createdAt";

  RemoteShortDataSourceImpl(
      {required FirebaseAuth auth,
      required FirebaseFirestore db,
      required FirebaseStorage storage,
      required Logger logger})
      : _auth = auth,
        _db = db,
        _storage = storage,
        _logger = logger;

  @override
  Stream<Iterable<ShortModel>> getShortStream(
      {String? afterAt, bool? descending}) {
    try {
      return _db
          .collection(CollectionName.short.name)
          .orderBy(orderBy, descending: descending ?? true)
          .where(orderBy,
              isLessThanOrEqualTo: afterAt ?? DateTime.now().toIso8601String())
          .snapshots()
          .asyncMap((event) => event.docs.map((doc) {
                _logger.d(doc.data());
                return ShortModel.fromJson(doc.data());
              }));
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<Iterable<ShortModel>> getShorts(
      {String? afterAt, int? take, bool? descending}) async {
    try {
      return await _db
          .collection(CollectionName.short.name)
          .orderBy(orderBy, descending: descending ?? true)
          .where(orderBy,
              isLessThan: afterAt ?? DateTime.now().toIso8601String())
          .limitToLast(take ?? 10)
          .get()
          .then(
              (res) => res.docs.map((doc) => ShortModel.fromJson(doc.data())));
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveShort(ShortModel model) async {
    try {
      await _db
          .collection(CollectionName.short.name)
          .doc(model.id)
          .set(_auditing(model).toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveVideo({required id, required File video}) async {
    try {
      final ref = _storage.ref('${BucketName.short.name}/$id');
      await ref.putFile(video);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<String> getShortDownloadUrl(String id) async {
    try {
      final ref = _storage.ref('${BucketName.short.name}/$id');
      return await ref.getDownloadURL();
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  ShortModel _auditing(ShortModel model, {String? id}) {
    if (model.id.isEmpty) {
      throw CustomException(
          errorCode: ErrorCode.invalidArgs, message: 'short id is not given');
    }
    return model.copyWith(
        id: id ?? model.id,
        createdBy: _auth.currentUser!.uid,
        createdAt: DateTime.now().toIso8601String());
  }
}
