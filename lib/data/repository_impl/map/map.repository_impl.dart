import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/constant/map.constant.dart';
import 'package:hot_place/core/util/response.util.dart';
import 'package:hot_place/data/data_source/map/map.data_source.dart';
import 'package:hot_place/data/model/map/categorized_place/categorized_place.model.dart';
import 'package:hot_place/data/model/map/place/place.model.dart';
import 'package:hot_place/domain/entity/map/categorized_place/categorized_place.entity.dart';
import 'package:hot_place/domain/entity/map/place/place.entity.dart';
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
  Future<KakaoApiResponseWrapper<PlaceEntity>> searchPlaces(String keyword,
      {int? page, int? size}) async {
    final res =
        await _mapDataSource.searchPlaces(keyword, page: page, size: size);
    return KakaoApiResponseWrapper<PlaceEntity>(
        totalCount: res.totalCount,
        data: res.data.map((e) => e.toEntity()).toList());
  }

  @override
  Future<KakaoApiResponseWrapper<CategorizedPlaceEntity>>
      searchPlacesByCategory(
          {required CategoryGroupCode category,
          Position? position,
          int? radius,
          int? page,
          int? size}) async {
    final pos = position ?? await getCurrentLocation();
    final res = await _mapDataSource.searchPlaceByCategory(
        category: category, latitude: pos.latitude, longitude: pos.longitude);
    return KakaoApiResponseWrapper(
        totalCount: res.totalCount,
        data: res.data.map((e) => e.toEntity()).toList());
  }
}
