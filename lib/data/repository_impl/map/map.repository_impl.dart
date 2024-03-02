import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:hot_place/data/data_source/map/map.data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repository/map/Map.repository.dart';

@Singleton(as: MapRepository)
class MapRepositoryImpl extends MapRepository {
  final MapDataSource _mapDataSource;

  MapRepositoryImpl({required MapDataSource mapDataSource})
      : _mapDataSource = mapDataSource;

  @override
  Future<Position> getCurrentLocation() async =>
      await _mapDataSource.getCurrentLocation();
}
