import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/features/user/data/data_source/credential.remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../user/data/data_source/base/credential.data_source.dart';
import '../../user/data/data_source/base/user.data_source.dart';
import '../../user/data/data_source/user.remote_data_source.dart';

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
