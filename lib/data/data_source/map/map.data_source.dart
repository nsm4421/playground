import 'package:geolocator/geolocator.dart';
import '../../../core/constant/map.constant.dart';
import '../../model/map/address/address.model.dart';
import '../../model/map/place/place.model.dart';
import '../../model/map/response/kakao_map_api_response.model.dart';

abstract class MapDataSource {
  Future<Position> getCurrentLocation();

  Future<KakaoMapApiResponseModel<AddressModel>> searchAddress(String keyword,
      {int? page, int? size});

  Future<KakaoMapApiResponseModel<PlaceModel>>
      searchPlacesByCategoryAndKeyword({
    required String keyword,
    CategoryGroupCode? category,
    required double latitude,
    required double longitude,
    int? page,
    int? radius,
    int? size,
  });

  Future<KakaoMapApiResponseModel<PlaceModel>> searchPlaceByCategory({
    required CategoryGroupCode category,
    required double latitude,
    required double longitude,
    int? page,
    int? radius,
    int? size,
  });
}
