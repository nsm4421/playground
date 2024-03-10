import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/constant/map.constant.dart';

part 'road_address.model.freezed.dart';

part 'road_address.model.g.dart';

// https://developers.kakao.com/docs/latest/ko/local/dev-guide#address-coord-response-body-document-road-address
@freezed
class RoadAddressModel with _$RoadAddressModel {
  const factory RoadAddressModel({
    String? address_name,
    String? region_1depth_name,
    String? region_2depth_name,
    String? region_3depth_name,
    String? road_name,
    MapYN? underground_yn,
    MapYN? main_building_no,
    MapYN? sub_building_no,
    String? building_name,
    String? zone_no,
    String? x,
    String? y,
  }) = _RoadAddressModel;

  factory RoadAddressModel.fromJson(Map<String, dynamic> json) =>
      _$RoadAddressModelFromJson(json);
}
