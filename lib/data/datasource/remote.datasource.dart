import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_app/data/datasource/chat/chat.datasource.impl.dart';

import 'auth/auth.datasource.dart';
import 'auth/auth.datasource.impl.dart';
import 'chat/chat.datasource.dart';
import 'short/short.datasource.dart';
import 'short/short.datasource.impl.dart';
import 'user/user.datasource.dart';
import 'user/user.datasource.impl.dart';

@module
abstract class RemoteDataSource {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _googleSignIn = GoogleSignIn();
  final _logger = Logger();

  @singleton
  RemoteAuthDataSource get auth => RemoteAuthDataSourceImpl(
      auth: _auth, googleSignIn: _googleSignIn, logger: _logger);

  @singleton
  RemoteUserDataSource get user => RemoteUserDataSourceImpl(
      auth: _auth, db: _db, storage: _storage, logger: _logger);

  @lazySingleton
  RemoteShortDataSource get short => RemoteShortDataSourceImpl(
      auth: _auth, db: _db, storage: _storage, logger: _logger);

  @lazySingleton
  RemoteChatDataSource get chat => RemoteChatDataSourceImpl(
      auth: _auth, db: _db, storage: _storage, logger: _logger);
}
