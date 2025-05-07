import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/constant/status.dart';
import 'package:portfolio/presentation/bloc/travel/travel.bloc_module.dart';

import '../../../../core/constant/travel_constant.dart';
import '../../../../domain/entity/travel/itinerary.entity.dart';
import '../../../../domain/usecase/travel/travel.usecase_module.dart';

part "recommend_travel.state.dart";

class RecommendItineraryCubit extends Cubit<RecommendItineraryState> {
  final TravelUseCase _useCase;

  RecommendItineraryCubit(this._useCase)
      : super(RecommendItineraryState(
            country: '',
            tendency: TendencyType.activity,
            accompany: AccompanyType.solo,
            searched: []));

  Future<void> search({
    required String country,
    required AccompanyType accompanyType,
    required TendencyType tendencyType,
  }) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final res = await _useCase.recommendItinerary.call(
          country: country,
          accompanyType: accompanyType,
          tendencyType: tendencyType);
      if (res.ok) {
        log(res.data.toString());
        emit(state.copyWith(
            country: country,
            accompany: accompanyType,
            tendency: tendencyType,
            status: Status.success,
            searched: res.data));
      }
    } catch (error) {
      log(error.toString());
      emit(state.copyWith(status: Status.error));
    }
  }
}
