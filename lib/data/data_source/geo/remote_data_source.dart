import 'package:geolocator/geolocator.dart';

import '../../../core/constant/response.constant.dart';
import '../../../domain/model/geo/load_address/load_address.model.dart';

abstract interface class RemoteGeoDataSource {
  String get kakaoApiKey;

  Future<LocationPermission> getPermission();

  Future<Position> getCurrentPosition();

  Future<KakaoApiResponseMapper<LoadAddressModel>>
      getCurrentAddressByCoordinate({required double x, required double y});
}
