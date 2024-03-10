import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/constant/map.constant.dart';

import '../../../data/model/map/response/kakao_map_api_response.model.dart';
import '../../entity/map/address/address.entity.dart';
import '../../entity/map/place/place.entity.dart';

abstract class MapRepository {
  Future<Position> getCurrentLocation();

  Future<KakaoMapApiResponseModel<AddressEntity>> searchAddress(String keyword,
      {int? page, int? size});

  Future<KakaoMapApiResponseModel<PlaceEntity>>
      searchPlacesByCategoryAndKeyword({
    required String keyword,
    CategoryGroupCode? category,
    Position? position,
    int? page,
    int? size,
    int? radius,
  });

  Future<KakaoMapApiResponseModel<PlaceEntity>> searchPlacesByCategory({
    required CategoryGroupCode category,
    Position? position,
    int? page,
    int? size,
    int? radius,
  });
}
