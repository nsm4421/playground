import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/map.constant.dart';

part 'address.model.freezed.dart';

part 'address.model.g.dart';

// https://developers.kakao.com/docs/latest/ko/local/dev-guide#address-coord-response-body-document-address
@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    String? address_name,
    String? region_1depth_name,
    String? region_2depth_name,
    String? region_3depth_name,
    String? region_3depth_h_name,
    String? h_code,
    String? b_code,
    MapYN? mountain_yn,
    String? main_address_no,
    String? sub_address_no,
    String? x,
    String? y,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}
