import 'package:injectable/injectable.dart';
import 'package:portfolio/data/repository_impl/travel/travel.repository_impl.dart';
import 'package:portfolio/domain/entity/travel/itinerary.entity.dart';

import '../../../core/constant/response_wrapper.dart';
import '../../../core/constant/travel_constant.dart';

part "scenario/recommend_itinerary.usecase.dart";

@lazySingleton
class TravelUseCase {
  final TravelRepository _repository;

  TravelUseCase(this._repository);

  RecommendItineraryUseCase get recommendItinerary =>
      RecommendItineraryUseCase(_repository);
}
