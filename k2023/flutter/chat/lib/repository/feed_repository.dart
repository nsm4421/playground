import 'dart:typed_data';

import 'package:chat_app/model/comment_model.dart';
import 'package:chat_app/model/feed_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final feedRepositoryProvider = Provider(
  (ref) => FeedRepository(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      storage: FirebaseStorage.instance),
);

class FeedRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  FeedRepository(
      {required FirebaseAuth auth,
      required FirebaseFirestore firestore,
      required FirebaseStorage storage})
      : _auth = auth,
        _firestore = firestore,
        _storage = storage;

  /// 피드목록 가져오기
  Future<List<FeedModel>> fetchFeeds({int? skipCount, int? takeCount}) async =>
      (await _firestore.collection("feeds").orderBy('createdAt').get().then(
              (snapshot) => takeCount == null
                  ? snapshot.docs.skip(skipCount ?? 0)
                  : snapshot.docs.skip(skipCount ?? 0).take(takeCount)))
          .map((doc) => FeedModel.fromJson(doc.data()))
          .toList();

  /// 댓글목록 가져오기
  Future<List<CommentModel>> fetchComments(
          {required String feedId, int? skipCount, int? takeCount}) async =>
      (await _firestore
              .collection("feeds")
              .doc(feedId)
              .collection('comments')
              .orderBy('createdAt')
              .get()
              .then((snapshot) => takeCount == null
                  ? snapshot.docs.skip(skipCount ?? 0)
                  : snapshot.docs.skip(skipCount ?? 0).take(takeCount)))
          .map((doc) => CommentModel.fromJson(doc.data()))
          .toList();

  /// 피드 생성하기
  Future<void> addFeed(FeedModel feed) async {
    final feedId = feed.feedId;
    if (feedId == null) throw Exception();
    await _firestore.collection('feeds').doc(feedId).set(feed.toJson());
  }

  /// 댓글 작성하기
  Future<void> addComment(CommentModel comment) async {
    final feedId = comment.feedId;
    final commentId = comment.commentId;
    if (feedId == null || commentId == null) throw Exception();

    await _firestore
        .collection('feeds')
        .doc(feedId)
        .collection('comments')
        .doc(commentId)
        .set(comment.toJson());
  }

  /// Storage에 이미지 업로드하고, 다운로드 링크 가져오기
  Future<String?> uploadImageAndGetDownloadLink(
    String feedId,
    Uint8List imgData,
  ) async {
    try {
      final storageRef = _storage.ref().child(feedId);
      await storageRef.putData(imgData);
      return await storageRef.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  /// 피드 Stream 가져오기
  Stream<List<FeedModel>> getFeedStream() => _firestore
      .collection('feeds')
      // 최신 피드 목록 순으로
      .orderBy('createdAt', descending: true)
      .snapshots()
      .asyncMap((e) async =>
          e.docs.map((doc) => FeedModel.fromJson(doc.data())).toList());

  /// 댓글 Stream 가져오기
  Stream<List<CommentModel>> getCommentStream(String feedId) => _firestore
      .collection('feeds')
      .doc(feedId)
      .collection('comments')
      // 최신 피드 목록 순으로
      .orderBy('createdAt', descending: true)
      .snapshots()
      .asyncMap((e) async =>
          e.docs.map((doc) => CommentModel.fromJson(doc.data())).toList());
}
