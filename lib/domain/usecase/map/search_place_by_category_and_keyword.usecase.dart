import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constant/map.constant.dart';
import '../../../data/model/map/response/kakao_map_api_response.model.dart';
import '../../entity/map/place/place.entity.dart';
import '../../repository/map/map.repository.dart';

@singleton
class SearchPlaceByCategoryAndKeywordUseCase {
  final MapRepository _repository;

  SearchPlaceByCategoryAndKeywordUseCase(this._repository);

  Future<KakaoMapApiResponseModel<PlaceEntity>> call({
    required String keyword,
    CategoryGroupCode? category,
    Position? position,
    int? radius,
    int? page,
    int? size,
  }) async =>
      await _repository.searchPlacesByCategoryAndKeyword(
          keyword: keyword,
          category: category,
          position: position,
          radius: radius,
          page: page,
          size: size);
}
