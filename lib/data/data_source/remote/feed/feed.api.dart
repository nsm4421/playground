import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_app/data/dto/feed/feed.dto.dart';
import 'package:my_app/data/dto/feed/feed_comment.dto.dart';
import 'package:my_app/data/mapper/feed_mapper.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';
import 'package:my_app/domain/model/feed/feed_comment.model.dart';

class FeedApi {
  FeedApi(
      {required FirebaseAuth auth,
      required FirebaseFirestore db,
      required FirebaseStorage storage})
      : _auth = auth,
        _db = db,
        _storage = storage;

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  final FirebaseStorage _storage;

  static const String _feedCollectionName = "feed";
  static const String _feedCommentCollectionName = "comment";
  static const String _orderByFieldName = "createdAt";

  /// Feed 목록 가져오기
  Future<List<FeedDto>> getFeeds({int take = 10, int skip = 0}) async =>
      (await _db
              .collection(_feedCollectionName)
              .orderBy(_orderByFieldName, descending: true)
              .get())
          .docs
          .skip(skip)
          .take(take)
          .map((e) => FeedDto.fromJson(e.data()))
          .toList();

  /// 댓글 목록 가져오기
  Future<List<FeedCommentDto>> getFeedComments(
          {required String feedId, int take = 10, int skip = 0}) async =>
      (await _db
              .collection(_feedCollectionName)
              .doc(feedId)
              .collection(_feedCollectionName)
              .orderBy(_orderByFieldName, descending: true)
              .get())
          .docs
          .skip(skip)
          .take(take)
          .map((e) => FeedCommentDto.fromJson(e.data()))
          .toList();

  /// Feed 목록 Stream
  Stream<List<FeedModel>> getFeedStream() => _db
          .collection(_feedCollectionName)
          .orderBy(_orderByFieldName, descending: true)
          .snapshots()
          .asyncMap((e) async {
        List<FeedModel> feeds = [];
        for (var doc in e.docs) {
          feeds.add(FeedDto.fromJson(doc.data()).toModel());
        }
        return feeds;
      });

  /// 댓글 목록 Stream
  Stream<List<FeedCommentModel>> getFeedCommentStream(String feedId) => _db
          .collection(_feedCollectionName)
          .doc(feedId)
          .collection(_feedCommentCollectionName)
          .orderBy(_orderByFieldName, descending: true)
          .snapshots()
          .asyncMap((e) async {
        List<FeedCommentModel> comments = [];
        for (var doc in e.docs) {
          comments.add(FeedCommentDto.fromJson(doc.data()).toModel());
        }
        return comments;
      });

  /// 피드 저장하기
  Future<void> saveFeed(
          {required String feedId, required FeedDto feed}) async =>
      await _db.collection(_feedCollectionName).doc(feedId).set(
          feed.copyWith(feedId: feedId, uid: _auth.currentUser!.uid).toJson());

  /// 댓글 저장하기
  Future<void> saveComment({
    required String commentId,
    required String feedId,
    required FeedCommentDto comment,
  }) async =>
      await _db
          .collection(_feedCollectionName)
          .doc(feedId)
          .collection(_feedCommentCollectionName)
          .doc(commentId)
          .set(comment
              .copyWith(
                  feedId: feedId,
                  commentId: commentId,
                  uid: _auth.currentUser!.uid)
              .toJson());

  /// 이미지 저장 후, 다운로드 링크 반환
  Future<String> saveFeedImage(
          {required String feedId,
          required String filename,
          required Uint8List imageData}) async =>
      await _storage
          .ref(_feedCollectionName)
          .child(feedId)
          .child(filename)
          .putData(imageData)
          .then((task) => task.ref.getDownloadURL());
}
