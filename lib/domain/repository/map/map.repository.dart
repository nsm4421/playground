import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/constant/map.constant.dart';

import '../../../core/util/response.util.dart';
import '../../entity/map/address/address.entity.dart';
import '../../entity/map/place/place.entity.dart';

abstract class MapRepository {
  Future<Position> getCurrentLocation();

  Future<KakaoApiResponseWrapper<AddressEntity>> searchAddress(String keyword,
      {int? page, int? size});

  Future<KakaoApiResponseWrapper<PlaceEntity>>
      searchPlacesByCategory({
    required CategoryGroupCode category,
    Position? position,
    int? page,
    int? radius,
    int? size,
  });
}
