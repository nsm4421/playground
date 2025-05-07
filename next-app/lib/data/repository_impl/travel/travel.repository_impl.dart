import 'package:injectable/injectable.dart';
import 'package:portfolio/core/util/exception.util.dart';
import 'package:portfolio/data/datasource/remote/travel/impl/travel.datasource_impl.dart';

import '../../../core/constant/response_wrapper.dart';
import '../../../core/constant/travel_constant.dart';
import '../../../domain/entity/travel/itinerary.entity.dart';

part '../../../domain/repository/travel/travel.repository.dart';

@Singleton(as: TravelRepository)
class TravelRepositoryImpl implements TravelRepository {
  final TravelDataSource _dataSource;

  TravelRepositoryImpl(this._dataSource);

  @override
  Future<ResponseWrapper<List<ItineraryEntity>>> recommendTravel({
    required String country,
    required AccompanyType accompanyType,
    required TendencyType tendencyType,
  }) async {
    try {
      return await _dataSource
          .recommendTrip(
              country: country,
              accompanyType: accompanyType,
              tendencyType: tendencyType)
          .then((res) => res.map(ItineraryEntity.fromModel).toList())
          .then(ResponseWrapper.success);
    } catch (error) {
      throw CustomException.from(error);
    }
  }
}
