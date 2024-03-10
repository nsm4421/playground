import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/core/constant/map.constant.dart';
import 'package:hot_place/domain/entity/map/categorized_place/categorized_place.entity.dart';

part 'categorized_place.model.freezed.dart';

part 'categorized_place.model.g.dart';

// https://developers.kakao.com/docs/latest/ko/local/dev-guide#search-by-category-response-body-document
@freezed
class CategorizedPlaceModel with _$CategorizedPlaceModel {
  const factory CategorizedPlaceModel(
      {String? id,
      String? place_name,
      CategoryGroupCode? category_group_code,
      String? category_group_name,
      String? phone,
      String? address_name,
      String? road_address_name,
      String? x,
      String? y,
      String? place_url,
      String? distance}) = _CategorizedPlaceModel;

  factory CategorizedPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$CategorizedPlaceModelFromJson(json);
}

extension CategorizedPlaceModelEx on CategorizedPlaceModel {
  CategorizedPlaceEntity toEntity() => CategorizedPlaceEntity(
        id: id,
        place_name: place_name,
        category_group_code: category_group_code,
        category_group_name:
            category_group_name ?? category_group_code?.description,
        phone: phone,
        address_name: address_name,
        road_address_name: road_address_name,
        longitude: x != null ? double.tryParse(x!) : null,
        latitude: y != null ? double.tryParse(y!) : null,
        place_url: place_url,
        distance: distance != null ? double.tryParse(distance!) : null,
      );
}
