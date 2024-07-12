import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/model/geo/load_address/load_address.model.dart';

part 'load_address.entity.freezed.dart';

part 'load_address.entity.g.dart';

@freezed
class LoadAddressEntity with _$LoadAddressEntity {
  const factory LoadAddressEntity({
    String? addressName, // 전체 도로명 주소
    String? region1depthName, //	지역 1Depth, 시도 단위
    String? region2depthName, // 지역 2Depth, 구 단위
    String? region3depthName, //	지역 3Depth, 면 단위
    String? roadName, //	도로명
    bool? undergroundYn, // 지하 여부, Y 또는 N
    String? mainBuildingNo, //	건물 본번
    String? buildingName, // 건물 이름
    String? zoneNo, //	우편번호(5자리)
  }) = _LoadAddressEntity;

  factory LoadAddressEntity.fromJson(Map<String, dynamic> json) =>
      _$LoadAddressEntityFromJson(json);

  factory LoadAddressEntity.fromModel(LoadAddressModel model) =>
      LoadAddressEntity(
        addressName: model.address_name.isNotEmpty ? model.address_name : null,
        region1depthName: model.region_1depth_name.isNotEmpty
            ? model.region_1depth_name
            : null,
        region2depthName: model.region_2depth_name.isNotEmpty
            ? model.region_2depth_name
            : null,
        region3depthName: model.region_3depth_name.isNotEmpty
            ? model.region_3depth_name
            : null,
        roadName: model.road_name.isNotEmpty ? model.road_name : null,
        undergroundYn: model.underground_yn.isNotEmpty
            ? (model.underground_yn == 'Y')
            : null,
        mainBuildingNo:
            model.main_building_no.isNotEmpty ? model.main_building_no : null,
        zoneNo: model.zone_no.isNotEmpty ? model.zone_no : null,
      );
}
