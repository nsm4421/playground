import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_reels.dto.freezed.dart';

part 'create_reels.dto.g.dart';

@freezed
class CreateReelsDto with _$CreateReelsDto {
  const factory CreateReelsDto({
    @Default('') String id,
    @Default('') String media,
    @Default('') String caption,
    @Default('') String created_by,
    @Default('') String created_at,
  }) = _CreateReelsDto;

  factory CreateReelsDto.fromJson(Map<String, dynamic> json) =>
      _$CreateReelsDtoFromJson(json);
}
