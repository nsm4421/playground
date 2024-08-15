part of '../../../data/repository_impl/travel/travel.repository_impl.dart';

abstract interface class TravelRepository {
  Future<ResponseWrapper<List<ItineraryEntity>>> recommendTravel(
      {required String country,
      required AccompanyType accompanyType,
      required TendencyType tendencyType});
}
