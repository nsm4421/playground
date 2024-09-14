import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/shared.export.dart';

part 'fetch_reels.dto.freezed.dart';
part 'fetch_reels.dto.g.dart';

@freezed
class FetchReelsDto with _$FetchReelsDto {
  const factory FetchReelsDto({
    @Default('') String id,
    @Default('') String media,
    @Default('') String caption,
    @Default('') String created_at,
    @Default('') String updated_at,
    // 작성자
    @Default(AuthorDto()) AuthorDto author,
  }) = _FetchReelsDto;

  factory FetchReelsDto.fromJson(Map<String, dynamic> json) =>
      _$FetchReelsDtoFromJson(json);
}