import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_app/data/dto/feed/feed.dto.dart';

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

  Future<void> saveFeed(
          {required String feedId, required FeedDto feed}) async =>
      await _db.collection(_feedCollectionName).doc(feedId).set(
          feed.copyWith(feedId: feedId, uid: _auth.currentUser!.uid).toJson());

  // 이미지 저장 후, 다운로드 링크 반환
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
