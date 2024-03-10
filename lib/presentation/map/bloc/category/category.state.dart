import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_place/core/constant/map.constant.dart';
import 'package:hot_place/core/constant/status.costant.dart';
import 'package:hot_place/domain/entity/map/categorized_place/categorized_place.entity.dart';

part 'category.state.freezed.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState({
    @Default(Status.initial) Status status,
    Position? currentLocation,
    CategoryGroupCode? category,
    @Default(<CategorizedPlaceEntity>[]) List<CategorizedPlaceEntity> places,
  }) = _CategoryState;
}
