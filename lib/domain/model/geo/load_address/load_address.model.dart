import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/geo/load_address/load_address.entity.dart';

part 'load_address.model.freezed.dart';

part 'load_address.model.g.dart';

@freezed
class LoadAddressModel with _$LoadAddressModel {
  const factory LoadAddressModel({
    @Default('') String address_name, // 전체 도로명 주소
    @Default('') String region_1depth_name, //	지역 1Depth, 시도 단위
    @Default('') String region_2depth_name, // 지역 2Depth, 구 단위
    @Default('') String region_3depth_name, //	지역 3Depth, 면 단위
    @Default('') String road_name, //	도로명
    @Default('') String underground_yn, // 지하 여부, Y 또는 N
    @Default('') String main_building_no, //	건물 본번
    @Default('') String building_name, // 건물 이름
    @Default('') String zone_no, //	우편번호(5자리)
  }) = _LoadAddressModel;

  factory LoadAddressModel.fromJson(Map<String, dynamic> json) =>
      _$LoadAddressModelFromJson(json);

  factory LoadAddressModel.fromEntity(
          LoadAddressEntity entity) =>
      LoadAddressModel(
          address_name: entity.addressName ?? '',
          region_1depth_name: entity.region1depthName ?? '',
          region_2depth_name: entity.region2depthName ?? '',
          region_3depth_name: entity.region3depthName ?? '',
          road_name: entity.roadName ?? '',
          underground_yn: (entity.undergroundYn != null)
              ? (entity.undergroundYn! ? "Y" : "N")
              : '',
          main_building_no: entity.mainBuildingNo ?? '',
          building_name: entity.buildingName ?? '',
          zone_no: entity.zoneNo ?? '');
}
