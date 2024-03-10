import 'package:geolocator/geolocator.dart';
import '../../../core/constant/map.constant.dart';
import '../../../core/util/response.util.dart';
import '../../model/map/address/address.model.dart';
import '../../model/map/place/place.model.dart';

abstract class MapDataSource {
  Future<Position> getCurrentLocation();

  Future<KakaoApiResponseWrapper<AddressModel>> searchAddress(String keyword,
      {int? page, int? size});

  Future<KakaoApiResponseWrapper<PlaceModel>> searchPlaceByCategory({
    required CategoryGroupCode category,
    required double latitude,
    required double longitude,
    int? page,
    int? radius,
    int? size,
  });
}
