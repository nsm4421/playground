import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:my_app/domain/model/feed/feed_comment.model.dart';

import '../../../core/constant/firebase.dart';
import '../../../core/exception/custom_exception.dart';

part 'feed_comment.datasource.dart';

class LocalFeedCommentDataSourceImpl implements LocalFeedCommentDataSource {}

class RemoteFeedCommentDataSourceImpl implements RemoteFeedCommentDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;
  final Logger _logger;

  static const orderBy = "createdAt";

  RemoteFeedCommentDataSourceImpl(
      {required FirebaseAuth auth,
      required FirebaseFirestore db,
      required FirebaseStorage storage,
      required Logger logger})
      : _auth = auth,
        _db = db,
        _storage = storage,
        _logger = logger;

  @override
  Future<Iterable<FeedCommentModel>> fetchComments(
      {required String afterAt,
      required String feedId,
      int take = 20,
      bool descending = false}) async {
    try {
      return await _db
          .collection(CollectionName.feed.name)
          .doc(feedId)
          .collection(CollectionName.feedComment.name)
          .where(orderBy, isLessThanOrEqualTo: afterAt)
          .orderBy(orderBy, descending: descending)
          .limitToLast(take)
          .get()
          .then((res) =>
              res.docs.map((doc) => doc.data()).map(FeedCommentModel.fromJson));
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Stream<Iterable<FeedCommentModel>> getCommentStream(
      {required String afterAt,
      required String feedId,
      bool descending = false}) {
    try {
      return _db
          .collection(CollectionName.feed.name)
          .doc(feedId)
          .collection(CollectionName.feedComment.name)
          .where(orderBy, isLessThanOrEqualTo: afterAt)
          .orderBy(orderBy, descending: descending)
          .snapshots()
          .asyncMap((event) => event.docs
              .map((doc) => doc.data())
              .map(FeedCommentModel.fromJson));
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveComment(FeedCommentModel model) async {
    try {
      return await _db
          .collection(CollectionName.feed.name)
          .doc(model.feedId)
          .collection(CollectionName.feedComment.name)
          .doc(model.id)
          .set(model.toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }
}
