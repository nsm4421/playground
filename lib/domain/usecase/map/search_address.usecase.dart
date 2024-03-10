import 'package:hot_place/core/util/response.util.dart';
import 'package:hot_place/domain/repository/map/map.repository.dart';
import 'package:injectable/injectable.dart';

import '../../entity/map/address/address.entity.dart';

@singleton
class SearchAddressUseCase {
  final MapRepository _repository;

  SearchAddressUseCase(this._repository);

  Future<KakaoApiResponseWrapper<AddressEntity>> call(String keyword,
          {int? page, int? size}) async =>
      await _repository.searchAddress(keyword, page: page, size: size);
}
