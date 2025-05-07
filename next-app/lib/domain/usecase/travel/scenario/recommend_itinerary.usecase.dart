part of "../travel.usecase_module.dart";

class RecommendItineraryUseCase {
  final TravelRepository _repository;

  RecommendItineraryUseCase(this._repository);

  Future<ResponseWrapper<List<ItineraryEntity>>> call(
      {required String country,
      required AccompanyType accompanyType,
      required TendencyType tendencyType}) async {
    return await _repository.recommendTravel(
        country: country,
        accompanyType: accompanyType,
        tendencyType: tendencyType);
  }
}
