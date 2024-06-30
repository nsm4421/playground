import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../user/account.dto.dart';

part 'fetch_feed_comment_response.dto.freezed.dart';

part 'fetch_feed_comment_response.dto.g.dart';

@freezed
class FetchFeedCommentResponseDto with _$FetchFeedCommentResponseDto {
  const factory FetchFeedCommentResponseDto({
    @Default('') String id,
    @Default('') String feedId,
    @Default('') String content,
    DateTime? createdAt,
    @Default(AccountDto()) AccountDto author,
  }) = _FetchFeedCommentResponseDto;

  factory FetchFeedCommentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FetchFeedCommentResponseDtoFromJson(json);
}
