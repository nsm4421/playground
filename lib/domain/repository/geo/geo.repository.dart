import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/geo/load_address/load_address.entity.dart';

import '../../../core/constant/response.constant.dart';

abstract interface class GeoRepository {
  Future<bool> getPermission();

  Future<Position> get getCurrentLocation;

  Future<Either<Failure, KakaoApiResponseMapper<LoadAddressEntity>>>
      getCurrentAddressByCoordinate(
          {required double latitude, required double longitude});
}
