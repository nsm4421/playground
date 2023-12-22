import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../domain/dto/feed/feed.dto.dart';
import '../../domain/model/feed/feed.model.dart';

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

  static const String _feedCollectionName = 'feed';

  /// get stream of feed order by created at field
  /// if uid is not given, then return stream for all feeds
  Stream<List<FeedModel>> getFeedStreamByUser({String? uid}) => (uid == null
          ? _db.collection(_feedCollectionName)
          : _db.collection(_feedCollectionName).where("uid", isEqualTo: uid))
      .orderBy('createdAt', descending: true)
      .snapshots()
      .asyncMap((e) async => e.docs
          .map((doc) => FeedDto.fromJson(doc.data()))
          .map((dto) => dto.toModel())
          .toList());

  /// save feed and return its id
  Future<String> saveFeed(FeedDto feed) async => await _db
      .collection(_feedCollectionName)
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
          .ref(_feedCollectionName)
          .child(fid)
          .child('${(const Uuid()).v1()}.jpg')
          .putData(imageData)
          .then((task) => task.ref.getDownloadURL())));

  /// get stream of whether current user like feed or not
  Stream<bool> getLikeStream(String fid) =>
      (_db.collection(_feedCollectionName).where("fid", isEqualTo: fid))
          .snapshots()
          .asyncMap((e) async => e.docs
              .map((doc) => FeedDto.fromJson(doc.data()))
              .map((dto) => dto.likeUidList.contains(_auth.currentUser?.uid))
              .toList()[0]);

  /// add current user id in likeUidList field
  Future<void> likeFeed(String fid) async =>
      await _db.collection(_feedCollectionName).doc(fid).update({
        'likeUidList': FieldValue.arrayUnion([_auth.currentUser?.uid])
      });

  /// remove current user id in likeUidList field
  Future<void> dislikeFeed(String fid) async =>
      await _db.collection(_feedCollectionName).doc(fid).update({
        'likeUidList': FieldValue.arrayRemove([_auth.currentUser?.uid])
      });
}
