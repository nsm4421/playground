import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/constant/map.constant.dart';
import 'package:hot_place/domain/entity/map/categorized_place/categorized_place.entity.dart';
import 'package:hot_place/domain/entity/map/place/place.entity.dart';

import '../../../core/util/response.util.dart';

abstract class MapRepository {
  Future<Position> getCurrentLocation();

  Future<KakaoApiResponseWrapper<PlaceEntity>> searchPlaces(String keyword,
      {int? page, int? size});

  Future<KakaoApiResponseWrapper<CategorizedPlaceEntity>>
      searchPlacesByCategory({
    required CategoryGroupCode category,
    Position? position,
    int? page,
    int? radius,
    int? size,
  });
}
