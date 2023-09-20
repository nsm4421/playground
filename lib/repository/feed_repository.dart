import 'dart:typed_data';

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
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FeedRepository(
      {required this.auth, required this.firestore, required this.storage});

  Future<List<FeedModel>> fetchFeed() async =>
      (await firestore.collection("feeds").get().then((res) => res.docs))
          .map((doc) => FeedModel.fromJson(doc.data()))
          .toList();

  Future<void> addFeed(FeedModel feed) async =>
      await firestore.collection('feed').add(feed.toJson());

  Future<String> uploadImageAndGetDownloadLink(
      String filename, Uint8List imgData) async {
    try {
      final storageRef = storage.ref().child(filename);
      await storageRef.putData(imgData);
      return await storageRef.getDownloadURL();
    } catch (e) {
      return "";
    }
  }
}
