import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/features/app/constant/user.constant.dart';

part 'contact.entity.freezed.dart';

@freezed
class ContactEntity with _$ContactEntity {
  const factory ContactEntity(
      {String? phoneNumber,
      String? label,
      String? uid,
      UserStatus? status,
      Uint8List? profile}) = _ContactEntity;
}
