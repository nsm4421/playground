import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/view_module.freezed.dart';

part '../../generated/view_module.g.dart';

@freezed
class ViewModuleDto with _$ViewModuleDto {
  const factory ViewModuleDto({
    @Default('') String type,
    @Default('') String title,
    @Default('') String subtitle,
    @Default('') String imageUrl,
  }) = _ViewModuleDto;

  factory ViewModuleDto.fromJson(Map<String, dynamic> json) =>
      _$ViewModuleDtoFromJson(json);
}
