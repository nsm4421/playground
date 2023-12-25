import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_app/domain/dto/feed/child_feed_comment.dto.dart';
import 'package:my_app/domain/dto/feed/parent_feed_comment.dto.dart';
import 'package:my_app/domain/model/feed/child_feed_comment.model.dart';
import 'package:my_app/domain/model/user/user.model.dart';
import 'package:uuid/uuid.dart';

import '../../core/constant/collection_name.enum.dart';
import '../../domain/dto/feed/feed.dto.dart';
import '../../domain/model/feed/feed.model.dart';
import '../../domain/model/feed/parent_feed_comment.model.dart';

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

  /// get stream of feed order by created at field
  /// if uid is not given, then return stream for all feeds
  Stream<List<FeedModel>> getFeedStreamByUser({String? uid}) => (uid == null
          ? _db.collection(CollectionName.feed.name)
          : _db
              .collection(CollectionName.feed.name)
              .where("uid", isEqualTo: uid))
      .orderBy('createdAt', descending: true)
      .snapshots()
      .asyncMap((e) async => await Future.wait(e.docs
              .map((doc) => FeedDto.fromJson(doc.data()))
              .map((dto) async {
            final user = UserModel.fromJson((await _db
                        .collection(CollectionName.user.name)
                        .doc(dto.uid)
                        .get())
                    .data() ??
                {});
            return dto.toModel().copyWith(
                nickname: user.nickname,
                profileImageUrl: user.profileImageUrls.isNotEmpty
                    ? user.profileImageUrls[0]
                    : null);
          }).toList()));

  /// save feed and return its id
  Future<String> saveFeed(FeedDto feed) async => await _db
      .collection(CollectionName.feed.name)
      .doc(feed.fid)
      .set(feed
          .copyWith(uid: _auth.currentUser!.uid, createdAt: DateTime.now())
          .toJson())
      .then((_) => feed.fid);

  /// save feed images in storage and return its download links
  Future<List<String>> saveFeedImages(
          {required String fid,
          required List<Uint8List> imageDataList}) async =>
      await Future.wait(imageDataList.map((imageData) async => await _storage
          .ref(CollectionName.feed.name)
          .child(fid)
          .child('${(const Uuid()).v1()}.jpg')
          .putData(imageData)
          .then((task) => task.ref.getDownloadURL())));

  /// get stream of whether current user like feed or not
  Stream<bool> getLikeStream(String fid) =>
      (_db.collection(CollectionName.feed.name).where("fid", isEqualTo: fid))
          .snapshots()
          .asyncMap((e) async => e.docs
              .map((doc) => FeedDto.fromJson(doc.data()))
              .map((dto) => dto.likeUidList.contains(_auth.currentUser?.uid))
              .toList()[0]);

  /// add current user id in likeUidList field
  Future<void> likeFeed(String fid) async =>
      await _db.collection(CollectionName.feed.name).doc(fid).update({
        'likeUidList': FieldValue.arrayUnion([_auth.currentUser?.uid])
      });

  /// remove current user id in likeUidList field
  Future<void> dislikeFeed(String fid) async =>
      await _db.collection(CollectionName.feed.name).doc(fid).update({
        'likeUidList': FieldValue.arrayRemove([_auth.currentUser?.uid])
      });

  /// get stream of parent comment order by created at field
  Stream<List<ParentFeedCommentModel>> getParentCommentStream(String fid) => _db
      .collection(CollectionName.feed.name)
      .doc(fid)
      .collection(CollectionName.parentComment.name)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .asyncMap(
        // join with user collection
        (e) async => Future.wait(
          e.docs.map(
            (commentDoc) async {
              final parentCommentDto =
                  ParentFeedCommentDto.fromJson(commentDoc.data());
              final user = UserModel.fromJson((await _db
                          .collection(CollectionName.user.name)
                          .doc(parentCommentDto.uid)
                          .get())
                      .data() ??
                  {});
              final childCommentCount = await _db
                  .collection(CollectionName.feed.name)
                  .doc(fid)
                  .collection(CollectionName.parentComment.name)
                  .doc(commentDoc.id)
                  .collection(CollectionName.childComment.name)
                  .count()
                  .get()
                  .then((res) => res.count);
              return parentCommentDto.toModel().copyWith(
                  nickname: user.nickname,
                  profileUrl: user.profileImageUrls.isNotEmpty
                      ? user.profileImageUrls[0]
                      : null,
                  childCommentCount: childCommentCount);
            },
          ),
        ),
      );

  /// get stream of child comment order by created at field
  Stream<List<ChildFeedCommentModel>> getChildCommentStream(
          {required String fid, required String parentCid}) =>
      _db
          .collection(CollectionName.feed.name)
          .doc(fid)
          .collection(CollectionName.parentComment.name)
          .doc(parentCid)
          .collection(CollectionName.childComment.name)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .asyncMap(
            // join with user collection
            (e) async => Future.wait(
              e.docs.map(
                (commentDoc) async {
                  final childCommentDto =
                      ChildFeedCommentDto.fromJson(commentDoc.data());
                  final user = UserModel.fromJson((await _db
                              .collection(CollectionName.user.name)
                              .doc(childCommentDto.uid)
                              .get())
                          .data() ??
                      {});
                  return childCommentDto.toModel().copyWith(
                      nickname: user.nickname,
                      profileUrl: user.profileImageUrls.isNotEmpty
                          ? user.profileImageUrls[0]
                          : null);
                },
              ),
            ),
          );

  /// save parent feed comment and return its id
  Future<void> saveParentComment(ParentFeedCommentDto parentComment) async {
    return await _db
        .collection(CollectionName.feed.name)
        .doc(parentComment.fid)
        .collection(CollectionName.parentComment.name)
        .doc(parentComment.cid)
        .set(parentComment
            .copyWith(uid: _auth.currentUser!.uid, createdAt: DateTime.now())
            .toJson())
        .then((_) => parentComment.cid);
  }

  /// save child feed comment and return its id
  Future<void> saveChildComment(ChildFeedCommentDto childComment) async {
    return await _db
        .collection(CollectionName.feed.name)
        .doc(childComment.fid)
        .collection(CollectionName.parentComment.name)
        .doc(childComment.parentCid)
        .collection(CollectionName.childComment.name)
        .doc(childComment.cid)
        .set(childComment
            .copyWith(uid: _auth.currentUser!.uid, createdAt: DateTime.now())
            .toJson())
        .then((_) => childComment.cid);
  }
}
