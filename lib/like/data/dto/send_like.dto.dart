import 'package:flutter/foundation.dart';
import 'package:flutter_app/shared/shared.export.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_like.dto.freezed.dart';

part 'send_like.dto.g.dart';

@freezed
class SendLikeDto with _$SendLikeDto {
  const factory SendLikeDto({
    @Default('') String id,
    @Default('') String reference_id,
    @Default(Tables.feeds) Tables reference_table,
  }) = _SendLikeDto;

  factory SendLikeDto.fromJson(Map<String, dynamic> json) =>
      _$SendLikeDtoFromJson(json);
}
