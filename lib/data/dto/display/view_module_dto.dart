import 'package:freezed_annotation/freezed_annotation.dart';

import 'product_info_dto.dart';

part '../../../generated/view_module_dto.freezed.dart';

part '../../../generated/view_module_dto.g.dart';

@freezed
class ViewModuleDto with _$ViewModuleDto {
  const factory ViewModuleDto({
    @Default('') String type,
    @Default('') String title,
    @Default('') String subtitle,
    @Default('') String imageUrl,
    @Default(<ProductInfoDto>[])  List<ProductInfoDto> products,
  }) = _ViewModuleDto;

  factory ViewModuleDto.fromJson(Map<String, dynamic> json) =>
      _$ViewModuleDtoFromJson(json);
}
