import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete.freezed.dart';

part 'delete.g.dart';

@freezed
class DeleteEmotionDto with _$DeleteEmotionDto {
  const factory DeleteEmotionDto({
    @Default('') String reference_id,
    @Default('') String reference_table,
  }) = _DeleteEmotionDto;

  factory DeleteEmotionDto.fromJson(Map<String, dynamic> json) =>
      _$DeleteEmotionDtoFromJson(json);
}
