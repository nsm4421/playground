import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_reels.dto.freezed.dart';

part 'edit_reels.dto.g.dart';

@freezed
class EditReelsDto with _$EditReelsDto {
  const factory EditReelsDto({
    @Default('') String id,
    String? media,
    String? caption
  }) = _EditReelsDto;

  factory EditReelsDto.fromJson(Map<String, dynamic> json) =>
      _$EditReelsDtoFromJson(json);
}
