import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/core/constant/map.constant.dart';
import 'package:hot_place/data/model/map/place/address/address.model.dart';
import 'package:hot_place/data/model/map/place/road_address/road_address.model.dart';
import 'package:hot_place/domain/entity/map/place/place.entity.dart';

part 'place.model.freezed.dart';

part 'place.model.g.dart';

// https://developers.kakao.com/docs/latest/ko/local/dev-guide#address-coord-response-body-document
@freezed
class PlaceModel with _$PlaceModel {
  const factory PlaceModel({
    String? x,
    String? y,
    AddressType? address_type,
    AddressModel? address,
    RoadAddressModel? road_address,
  }) = _PlaceModel;

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);
}

extension PlaceModelEx on PlaceModel {
  PlaceEntity toEntity() => PlaceEntity(
        latitude: double.tryParse(x ?? '37.502'),
        longitude: double.tryParse(y ?? ' 126.947'),
        addressName: address?.address_name,
        roadAddressName: road_address?.address_name,
      );
}
