import 'package:flutter/foundation.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_like.dto.freezed.dart';

part 'save_like.dto.g.dart';

@freezed
class SaveLikeDto with _$SaveLikeDto {
  const factory SaveLikeDto({
    @Default('') String id,
    @Default('') String reference_id,
    @Default(Tables.feeds) Tables reference_table,
  }) = _SaveLikeDto;

  factory SaveLikeDto.fromJson(Map<String, dynamic> json) =>
      _$SaveLikeDtoFromJson(json);
}
