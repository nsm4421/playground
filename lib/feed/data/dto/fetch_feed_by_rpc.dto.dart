import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_feed_by_rpc.dto.freezed.dart';

part 'fetch_feed_by_rpc.dto.g.dart';

@freezed
class FetchFeedByRpcDto with _$FetchFeedByRpcDto {
  const factory FetchFeedByRpcDto({
    @Default('') String feed_id,
    @Default('') String media,
    @Default(<String>[]) List<String> hashtags,
    @Default('') String caption,
    @Default('') String created_at,
    @Default('') String updated_at,
    @Default('') String author_id,
    @Default('') String author_username,
    @Default('') String author_avatar_url,
    @Default(0) int like_count,
    @Default(false) bool is_like,
  }) = _FetchFeedByRpcDto;

  factory FetchFeedByRpcDto.fromJson(Map<String, dynamic> json) =>
      _$FetchFeedByRpcDtoFromJson(json);
}
