import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/menu_dto.freezed.dart';

part '../../generated/menu_dto.g.dart';

@freezed
class MenuDto with _$MenuDto {
  const factory MenuDto({
    @Default('') String title,
    @Default(-1) int tabId,
  }) = _MenuDto;

  factory MenuDto.fromJson(Map<String, dynamic> json) =>
      _$MenuDtoFromJson(json);
}
