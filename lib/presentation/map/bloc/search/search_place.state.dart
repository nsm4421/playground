import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/constant/map.constant.dart';
import '../../../../core/constant/status.costant.dart';
import '../../../../domain/entity/map/place/place.entity.dart';

part 'search_place.state.freezed.dart';

@freezed
class SearchPlaceState with _$SearchPlaceState {
  const factory SearchPlaceState({
    @Default(Status.initial) Status status,
    Position? currentLocation,
    String? keyword,
    CategoryGroupCode? category,
    @Default(<PlaceEntity>[]) List<PlaceEntity> places,
  }) = _SearchPlaceState;
}
