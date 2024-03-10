import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/constant/map.constant.dart';
import 'package:injectable/injectable.dart';

import '../../../core/util/response.util.dart';
import '../../entity/map/place/place.entity.dart';
import '../../repository/map/map.repository.dart';

@singleton
class SearchPlacesByCategoryUseCase {
  final MapRepository _repository;

  SearchPlacesByCategoryUseCase(this._repository);

  Future<KakaoApiResponseWrapper<PlaceEntity>> call({
    required CategoryGroupCode category,
    Position? position,
    int? radius,
    int? page,
    int? size,
  }) async =>
      await _repository.searchPlacesByCategory(
          category: category,
          position: position,
          radius: radius,
          page: page,
          size: size);
}
