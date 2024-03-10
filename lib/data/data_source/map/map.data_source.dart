import 'package:geolocator/geolocator.dart';
import 'package:hot_place/data/model/map/place/place.model.dart';

import '../../../core/constant/map.constant.dart';
import '../../../core/util/response.util.dart';
import '../../model/map/categorized_place/categorized_place.model.dart';

abstract class MapDataSource {
  Future<Position> getCurrentLocation();

  Future<KakaoApiResponseWrapper<PlaceModel>> searchPlaces(String keyword,
      {int? page, int? size});

  Future<KakaoApiResponseWrapper<CategorizedPlaceModel>> searchPlaceByCategory({
    required CategoryGroupCode category,
    required double latitude,
    required double longitude,
    int? page,
    int? radius,
    int? size,
  });
}
