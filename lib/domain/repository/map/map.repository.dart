import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/constant/map.constant.dart';
import 'package:hot_place/data/model/response/response.model.dart';

import '../../../data/model/map/response/kakao_map_api_response.model.dart';
import '../../entity/map/address/address.entity.dart';
import '../../entity/map/place/place.entity.dart';

abstract class MapRepository {
  Future<ResponseModel<Position>> getCurrentLocation();

  Future<ResponseModel<KakaoMapApiResponseModel<AddressEntity>>> searchAddress(
      {required String keyword, required int page, required int size});

  Future<ResponseModel<KakaoMapApiResponseModel<PlaceEntity>>>
      searchPlacesByCategoryAndKeyword({
    required String keyword,
    CategoryGroupCode? category,
    Position? position,
    required int page,
    required int size,
    required int radius,
  });

  Future<ResponseModel<KakaoMapApiResponseModel<PlaceEntity>>>
      searchPlacesByCategory({
    required CategoryGroupCode category,
    Position? position,
    required int page,
    required int size,
    required int radius,
  });
}
