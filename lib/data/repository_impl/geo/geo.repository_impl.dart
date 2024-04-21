import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';

import 'package:hot_place/core/constant/response.constant.dart';
import 'package:hot_place/core/error/custom_exception.dart';
import 'package:hot_place/core/error/failure.constant.dart';
import 'package:hot_place/data/data_source/geo/remote_data_source.dart';
import 'package:hot_place/data/entity/geo/load_address/load_address.entity.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/repository/geo/geo.repository.dart';

@Singleton(as: GeoRepository)
class GeoRepositoryImpl implements GeoRepository {
  final RemoteGeoDataSource _dataSource;

  GeoRepositoryImpl(this._dataSource);

  @override
  Future<Position> get getCurrentLocation async =>
      await _dataSource.getCurrentPosition();

  @override
  Future<Either<Failure, KakaoApiResponseMapper<LoadAddressEntity>>>
  getCurrentAddressByCoordinate(
      {required double latitude, required double longitude}) async {
    try {
      final res = await _dataSource
          .getCurrentAddressByCoordinate(x: longitude, y: latitude)
          .then((res) => KakaoApiResponseMapper(
              meta: res.meta,
              documents: res.documents.map(LoadAddressEntity.fromModel)));
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
