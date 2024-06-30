import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/dto.constant.dart';

part 'save_like_request.dto.freezed.dart';
part 'save_like_request.dto.g.dart';

@freezed
class SaveLikeRequestDto with _$SaveLikeRequestDto {
  const factory SaveLikeRequestDto({
    @Default(LikeType.feed) LikeType type,
    @Default('') String referenceId,
  }) = _SaveLikeRequestDto;

  factory SaveLikeRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SaveLikeRequestDtoFromJson(json);
}