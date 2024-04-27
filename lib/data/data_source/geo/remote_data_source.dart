import 'package:geolocator/geolocator.dart';

import '../../../domain/model/geo/load_address/load_address.model.dart';

abstract interface class RemoteGeoDataSource {
  String get kakaoApiKey;

  Future<LocationPermission> getPermission();

  Future<Position> getCurrentPosition();

  Future<Iterable<LoadAddressModel>> getCurrentAddressByCoordinate(
      {required double latitude, required double longitude});
}
