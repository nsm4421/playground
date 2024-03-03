import 'package:geolocator/geolocator.dart';
import 'package:hot_place/domain/entity/map/place.entity.dart';

import '../../../core/util/page.util.dart';

abstract class MapRepository {
  Future<Position> getCurrentLocation();

  Future<CustomPageable<PlaceEntity>> searchPlaces(String keyword,
      {int? page, int? size});
}
