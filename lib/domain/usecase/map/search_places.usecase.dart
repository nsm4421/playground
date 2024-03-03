import 'package:hot_place/core/util/page.util.dart';
import 'package:hot_place/domain/entity/map/place.entity.dart';
import 'package:hot_place/domain/repository/map/map.repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class SearchPlacesUseCase {
  final MapRepository _repository;

  SearchPlacesUseCase(this._repository);

  Future<CustomPageable<PlaceEntity>> call(String keyword,
          {int? page, int? size}) async =>
      await _repository.searchPlaces(keyword, page: page, size: size);
}
