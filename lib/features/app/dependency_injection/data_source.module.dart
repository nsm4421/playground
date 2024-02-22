import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/features/chat/data/data_source/chat.remote_data_source.dart';
import 'package:hot_place/features/user/data/data_source/credential.remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../user/data/data_source/user.remote_data_source.dart';

@module
abstract class DataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @singleton
  RemoteUserDataSource get userDataSource =>
      RemoteUserDataSource(auth: _auth, fireStore: _fireStore);

  @singleton
  RemoteCredentialDataSource get credentialRemoteSource =>
      RemoteCredentialDataSource(auth: _auth, fireStore: _fireStore);

  @singleton
  RemoteChatDataSource get chatDataSource =>
      RemoteChatDataSource(auth: _auth, fireStore: _fireStore);
}
