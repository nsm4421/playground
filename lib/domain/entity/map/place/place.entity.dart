import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'place.entity.freezed.dart';

part 'place.entity.g.dart';

@freezed
class PlaceEntity with _$PlaceEntity {
  const factory PlaceEntity({
    double? latitude,
    double? longitude,
    String? name,
    String? roadAddressName,
    String? addressName,
    String? phone,
  }) = _PlaceEntity;

  factory PlaceEntity.fromJson(Map<String, dynamic> json) =>
      _$PlaceEntityFromJson(json);
}
