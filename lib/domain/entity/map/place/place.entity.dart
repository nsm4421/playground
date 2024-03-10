import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/map.constant.dart';

part 'place.entity.freezed.dart';

part 'place.entity.g.dart';

@freezed
class PlaceEntity with _$PlaceEntity {
  const factory PlaceEntity(
      {String? id,
      String? place_name,
      CategoryGroupCode? category_group_code,
      String? category_group_name,
      String? phone,
      String? address_name,
      String? road_address_name,
      double? latitude,
      double? longitude,
      String? place_url,
      double? distance}) = _PlaceEntity;

  factory PlaceEntity.fromJson(Map<String, dynamic> json) =>
      _$PlaceEntityFromJson(json);
}
