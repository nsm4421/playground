import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/api/chat/chat.api.dart';
import 'package:my_app/api/feed/feed.api.dart';
import 'package:my_app/api/user/user.api.dart';

@module
abstract class ApiModule {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @singleton
  UserApi get authApi => UserApi(auth: _auth, db: _db, storage: _storage);

  @singleton
  FeedApi get feedApi => FeedApi(auth: _auth, db: _db, storage: _storage);

  @singleton
  ChatApi get chatApi => ChatApi(auth: _auth, db: _db, storage: _storage);
}
