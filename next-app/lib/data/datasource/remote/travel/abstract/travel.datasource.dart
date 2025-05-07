part of "../impl/travel.datasource_impl.dart";

abstract interface class TravelDataSource {
  Future<Iterable<ItineraryModel>> recommendTrip({
    required String country,
    required TendencyType tendencyType,
    required AccompanyType accompanyType,
  });
}
