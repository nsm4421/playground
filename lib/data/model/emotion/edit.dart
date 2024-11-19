import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:travel/core/constant/constant.dart';

part 'edit.freezed.dart';
part 'edit.g.dart';

@freezed
class EditEmotionDto with _$EditEmotionDto {
  const factory EditEmotionDto({
    @Default('') String reference_id,
    @Default('') String reference_table,
    @Default(Emotions.like) Emotions emotion,
  }) = _EditEmotionDto;

  factory EditEmotionDto.fromJson(Map<String, dynamic> json) =>
      _$EditEmotionDtoFromJson(json);
}