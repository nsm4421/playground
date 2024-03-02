import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'map.state.freezed.dart';

part 'map.state.g.dart';

@freezed
class MapState with _$MapState {
  const factory MapState({
    @Default(false) bool isPermitted,
    @Default(false) bool isError,
    double? lat, // 위도
    double? lng, // 경도
  }) = _MapState;

  factory MapState.fromJson(Map<String, dynamic> json) =>
      _$MapStateFromJson(json);
}
