import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/map.constant.dart';
import '../../../../domain/entity/map/address/address.entity.dart';
import 'detail_address/detail_address.model.dart';
import 'road_address/road_address.model.dart';

part 'address.model.freezed.dart';

part 'address.model.g.dart';

@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    String? x,
    String? y,
    AddressType? address_type,
    DetailAddressModel? address,
    RoadAddressModel? road_address,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

extension AddressModelEx on AddressModel {
  AddressEntity toEntity() => AddressEntity(
        latitude: double.tryParse(x ?? '37.502'),
        longitude: double.tryParse(y ?? ' 126.947'),
        addressName: address?.address_name,
        roadAddressName: road_address?.address_name,
      );
}
