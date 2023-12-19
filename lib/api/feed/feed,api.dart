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
      .asyncMap((e) async =>
          e.docs.map((doc) => FeedModel.fromJson(doc.data())).toList());

  /// save feed and return its id
  Future<String> saveFeed(FeedDto feed) async {
    // create feed id
    final fid = feed.fid.isNotEmpty ? feed.fid : const Uuid().v1();

    // TODO : 이미지 업로드 기능

    // save in DB
    await _db.collection(_feedCollectionName).doc(fid).set(feed
        .copyWith(
          // TODO : profileImageUrl 필드 추가
          uid: _auth.currentUser!.uid,
          fid: fid,
          createdAt: DateTime.now(),
        )
        .toJson());
    return fid;
  }
}
