import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_place/data/data_source/map/map.data_source.dart';

import 'package:geolocator/geolocator.dart';

class RemoteMapDatSource extends MapDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;
  final Geolocator _geoLocator;

  RemoteMapDatSource(
      {required FirebaseAuth auth,
      required FirebaseFirestore fireStore,
      required Geolocator geoLocator})
      : _auth = auth,
        _fireStore = fireStore,
        _geoLocator = geoLocator;

  @override
  Future<Position> getCurrentLocation() async =>
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
}
