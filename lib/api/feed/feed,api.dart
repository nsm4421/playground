import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../../domain/dto/feed/feed.dto.dart';

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

  String? get currentUid => _auth.currentUser?.uid;

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
