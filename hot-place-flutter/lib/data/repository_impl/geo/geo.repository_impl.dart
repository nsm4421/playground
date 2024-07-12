import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';

import 'package:hot_place/core/constant/response.constant.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/geo/remote_data_source.dart';
import 'package:hot_place/data/entity/geo/load_address/load_address.entity.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/repository/geo/geo.repository.dart';

@LazySingleton(as: GeoRepository)
class GeoRepositoryImpl implements GeoRepository {
  final RemoteGeoDataSource _dataSource;

  GeoRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, Position>> get getCurrentLocation async {
    try {
      final res = await _dataSource.getCurrentPosition();
      return right(res);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<Either<Failure, Iterable<LoadAddressEntity>>>
      getCurrentAddressByCoordinate(
          {required double latitude, required double longitude}) async {
    try {
      final res = await _dataSource
          .getCurrentAddressByCoordinate(
              longitude: longitude, latitude: latitude)
          .then((res) => res.map((e) => LoadAddressEntity.fromModel(e)));
      return right(res);
    } on CustomException catch (err) {
      return left(Failure(code: err.code, message: err.message));
    }
  }

  @override
  Future<bool> getPermission() async {
    try {
      await _dataSource.getPermission();
      return true;
    } catch (err) {
      return false;
    }
  }
}
