import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/data/data_source/user/impl/credential.remote_data_source.dart';
import 'package:injectable/injectable.dart';

import 'user/credential.data_source.dart';
import 'user/user.data_source.dart';
import 'user/impl/user.remote_data_source.dart';

@module
abstract class DataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @singleton
  UserDataSource get userDataSource =>
      RemoteUserDataSource(fireStore: _fireStore);

  @singleton
  CredentialDataSource get credentialRemoteSource =>
      RemoteCredentialDataSource(auth: _auth);
}
