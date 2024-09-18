import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_feed_by_rpc.dto.freezed.dart';

part 'fetch_feed_by_rpc.dto.g.dart';

@freezed
class FetchFeedByRpcDto with _$FetchFeedByRpcDto {
  const factory FetchFeedByRpcDto({
    /// 피드
    @Default('') String id,
    @Default('') String media,
    @Default(<String>[]) List<String> hashtags,
    @Default('') String caption,
    @Default('') String created_at,
    @Default('') String updated_at,

    /// 작성자 정보
    @Default('') String author_id,
    @Default('') String author_username,
    @Default('') String author_avatar_url,

    /// 좋아요
    @Default(0) int like_count, // 좋아요 개수
    @Default(false) bool is_like, // 현재 로그인 유저가 해당 게시글에 좋아요를 눌렀는지 여부

    /// 댓글
    @Default(0) int comment_count, // 부모댓글 개수
    String? latest_comment_id, // 최신 부모 댓글 id
    String? latest_comment_content, // 최신 부모 댓글 본문
    String? lastet_comment_created_at, // 최신 부모 댓글 작성시간
  }) = _FetchFeedByRpcDto;

  factory FetchFeedByRpcDto.fromJson(Map<String, dynamic> json) =>
      _$FetchFeedByRpcDtoFromJson(json);
}
