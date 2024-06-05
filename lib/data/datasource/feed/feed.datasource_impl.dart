import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:my_app/core/constant/error_code.dart';

import '../../../core/constant/firebase.dart';
import '../../../core/exception/custom_exception.dart';
import '../../../domain/model/feed/feed.model.dart';

part 'feed.datasource.dart';

class LocalFeedDataSourceImpl implements LocalFeedDataSource {}

class RemoteFeedDataSourceImpl implements RemoteFeedDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;
  final Logger _logger;

  static const orderBy = "createdAt";

  RemoteFeedDataSourceImpl(
      {required FirebaseAuth auth,
      required FirebaseFirestore db,
      required FirebaseStorage storage,
      required Logger logger})
      : _auth = auth,
        _db = db,
        _storage = storage,
        _logger = logger;

  @override
  Stream<Iterable<FeedModel>> getFeedStream(
      {required String afterAt, bool descending = false}) {
    try {
      return _db
          .collection(CollectionName.feed.name)
          .orderBy(orderBy, descending: descending)
          .where(orderBy, isLessThanOrEqualTo: afterAt)
          .snapshots()
          .asyncMap((event) => event.docs.map((doc) {
                return FeedModel.fromJson(doc.data());
              }));
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<Iterable<FeedModel>> fetchFeeds(
      {required String afterAt, int take = 20, bool descending = false}) async {
    try {
      return await _db
          .collection(CollectionName.feed.name)
          .orderBy(orderBy, descending: descending)
          .where(orderBy, isLessThan: afterAt)
          .limitToLast(take)
          .get()
          .then((res) => res.docs.map((doc) => FeedModel.fromJson(doc.data())));
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<String> getDownloadUrl(String path) async {
    try {
      return await _storage.ref('${BucketName.feed}/$path').getDownloadURL();
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveFeed(FeedModel model) async {
    try {
      return await _db
          .collection(CollectionName.feed.name)
          .doc(model.id)
          .set(_audit(model).toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> uploadFile({required String path, required File file}) async {
    try {
      await _storage.ref('${BucketName.feed.name}/$path').putFile(file);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  FeedModel _audit(FeedModel model) {
    if (model.id.isEmpty) {
      throw CustomException(errorCode: ErrorCode.invalidArgs);
    }
    return model.copyWith(
        createdBy: _auth.currentUser!.uid,
        createdAt: model.createdAt ?? DateTime.now().toIso8601String());
  }
}
