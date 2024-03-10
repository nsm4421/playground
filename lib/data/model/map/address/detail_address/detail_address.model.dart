import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/constant/map.constant.dart';

part 'detail_address.model.freezed.dart';

part 'detail_address.model.g.dart';

@freezed
class DetailAddressModel with _$DetailAddressModel {
  const factory DetailAddressModel({
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
  }) = _DetailAddressModel;

  factory DetailAddressModel.fromJson(Map<String, dynamic> json) =>
      _$DetailAddressModelFromJson(json);
}
