import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/dto.constant.dart';

part 'delete_like_request.dto.freezed.dart';

part 'delete_like_request.dto.g.dart';

@freezed
class DeleteLikeRequestDto with _$DeleteLikeRequestDto {
  const factory DeleteLikeRequestDto({
    @Default('') String referenceId,
    @Default(LikeType.feed) LikeType type,
  }) = _DeleteLikeRequestDto;

  factory DeleteLikeRequestDto.fromJson(Map<String, dynamic> json) =>
      _$DeleteLikeRequestDtoFromJson(json);
}
