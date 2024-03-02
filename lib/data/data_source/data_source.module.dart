import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_place/data/data_source/chat/chat.data_source.dart';
import 'package:hot_place/data/data_source/chat/impl/chat.remote_data_source.dart';
import 'package:hot_place/data/data_source/map/impl/map.remote_data_source.dart';
import 'package:hot_place/data/data_source/map/map.data_source.dart';
import 'package:hot_place/data/data_source/user/impl/credential.remote_data_source.dart';
import 'package:injectable/injectable.dart';

import 'user/credential.data_source.dart';
import 'user/user.data_source.dart';
import 'user/impl/user.remote_data_source.dart';

@module
abstract class DataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final Geolocator _geoLocator = Geolocator();

  @singleton
  UserDataSource get userDataSource =>
      RemoteUserDataSource(fireStore: _fireStore);

  @singleton
  CredentialDataSource get credentialRemoteSource =>
      RemoteCredentialDataSource(auth: _auth);

  @singleton
  ChatDataSource get chatRepository =>
      RemoteChatDataSource(auth: _auth, fireStore: _fireStore);

  @singleton
  MapDataSource get mapDataSource => RemoteMapDatSource(
      auth: _auth, fireStore: _fireStore, geoLocator: _geoLocator);
}
