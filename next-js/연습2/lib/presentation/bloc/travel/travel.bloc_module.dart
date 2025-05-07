import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/domain/usecase/travel/travel.usecase_module.dart';
import 'package:portfolio/presentation/bloc/travel/recommend/recommend_travel.cubit.dart';

import '../../../core/constant/status.dart';

part "travel.state.dart";

@lazySingleton
class TravelBlocModule {
  final TravelUseCase _useCase;

  TravelBlocModule(this._useCase);

  RecommendItineraryCubit get recommend => RecommendItineraryCubit(_useCase);
}
