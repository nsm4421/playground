import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

import '../../../domain/entity/map/place.entity.dart';

part 'map.state.freezed.dart';

@freezed
class MapState with _$MapState {
  const factory MapState({
    @Default(true) bool isLoading,
    @Default(false) bool isError,
    Position? currentLocation,
  }) = _MapState;
}
