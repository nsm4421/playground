import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/entity/geo/load_address/load_address.entity.dart';

abstract interface class GeoRepository {
  Future<bool> getPermission();

  Future<Either<Failure, Position>> get getCurrentLocation;

  Future<Either<Failure, Iterable<LoadAddressEntity>>>
      getCurrentAddressByCoordinate(
          {required double latitude, required double longitude});
}
