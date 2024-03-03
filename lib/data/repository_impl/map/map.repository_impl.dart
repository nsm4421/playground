import 'package:flutter/material.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:hot_place/core/util/page.util.dart';
import 'package:hot_place/data/data_source/map/map.data_source.dart';
import 'package:hot_place/data/model/map/place/place.model.dart';
import 'package:hot_place/domain/entity/map/place.entity.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repository/map/map.repository.dart';

@Singleton(as: MapRepository)
class MapRepositoryImpl extends MapRepository {
  final MapDataSource _mapDataSource;

  MapRepositoryImpl({required MapDataSource mapDataSource})
      : _mapDataSource = mapDataSource;

  @override
  Future<Position> getCurrentLocation() async =>
      await _mapDataSource.getCurrentLocation();

  @override
  Future<CustomPageable<PlaceEntity>> searchPlaces(String keyword,
      {int? page, int? size}) async {
    final res =
        await _mapDataSource.searchPlaces(keyword, page: page, size: size);
    return CustomPageable<PlaceEntity>(
        totalCount: res.totalCount,
        data: res.data.map((e) => e.toEntity()).toList());
  }
}
