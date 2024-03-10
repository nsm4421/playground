import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/core/constant/map.constant.dart';

part 'categorized_place.entity.freezed.dart';

part 'categorized_place.entity.g.dart';

@freezed
class CategorizedPlaceEntity with _$CategorizedPlaceEntity {
  const factory CategorizedPlaceEntity(
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
      double? distance}) = _CategorizedPlaceEntity;

  factory CategorizedPlaceEntity.fromJson(Map<String, dynamic> json) =>
      _$CategorizedPlaceEntityFromJson(json);
}
