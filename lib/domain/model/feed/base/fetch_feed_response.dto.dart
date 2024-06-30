import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/dto.constant.dart';
import '../../user/account.dto.dart';

part 'fetch_feed_response.dto.freezed.dart';

part 'fetch_feed_response.dto.g.dart';

@freezed
class FetchFeedResponseDto with _$FetchFeedResponseDto {
  const factory FetchFeedResponseDto({
    @Default('') String id,
    @Default('') String content,
    @Default('') String caption,
    @Default('') String media,
    @Default(MediaType.image) MediaType type,
    @Default(<String>[]) List<String> hashtags,
    DateTime? createdAt,
    @Default(AccountDto()) AccountDto author,
  }) = _FetchFeedResponseDto;

  factory FetchFeedResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FetchFeedResponseDtoFromJson(json);
}
