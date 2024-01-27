import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/core/constant/enums/view_module_type.enum.dart';
import 'package:my_app/data/dto/user/user.dto.dart';

part 'view_module.dto.freezed.dart';

part 'view_module.dto.g.dart';

@freezed
class ViewModuleDto with _$ViewModuleDto {
  const factory ViewModuleDto({
    @Default(ViewModuleType.none) ViewModuleType? type,
    @Default(UserDto()) UserDto? user,
    @Default('') String? content,
    @Default('') String? imageUrl,
  }) = _ViewModuleDto;

  factory ViewModuleDto.fromJson(Map<String, dynamic> json) =>
      _$ViewModuleDtoFromJson(json);
}
