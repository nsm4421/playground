import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../user/data/data_source/user.remote_data_source.dart';

@module
abstract class DataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @singleton
  RemoteUserDataSource get userDataSource =>
      RemoteUserDataSource(auth: _auth, fireStore: _fireStore);
}
