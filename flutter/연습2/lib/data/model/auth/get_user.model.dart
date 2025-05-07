import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.model.dart';

part 'get_user.model.freezed.dart';

part 'get_user.model.g.dart';

@freezed
class GetUserDto with _$GetUserDto {
  const factory GetUserDto(
      {required String message, required UserModel payload}) = _GetUserDto;

  factory GetUserDto.fromJson(Map<String, dynamic> json) =>
      _$GetUserDtoFromJson(json);
}

