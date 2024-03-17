import 'package:hot_place/data/model/map/response/kakao_map_api_response.model.dart';
import 'package:hot_place/domain/entity/result/result.entity.dart';
import 'package:hot_place/domain/repository/map/map.repository.dart';
import 'package:injectable/injectable.dart';

import '../../entity/map/address/address.entity.dart';

@singleton
class SearchAddressUseCase {
  final MapRepository _repository;

  SearchAddressUseCase(this._repository);

  Future<ResultEntity<KakaoMapApiResponseModel<AddressEntity>>> call(
    String keyword, {
    int? page,
    int? size,
  }) async =>
      await _repository
          .searchAddress(keyword: keyword, page: page ?? 1, size: size ?? 20)
          .then(ResultEntity<KakaoMapApiResponseModel<AddressEntity>>
              .fromResponse);
}
