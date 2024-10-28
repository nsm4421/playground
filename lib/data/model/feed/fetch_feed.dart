import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_feed.freezed.dart';

part 'fetch_feed.g.dart';

@freezed
class FetchFeedModel with _$FetchFeedModel {
  const factory FetchFeedModel({
    @Default('') String id,
    String? location,
    @Default('') String content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
    @Default(<String>[]) List<String> captions,
    @Default(true) bool is_private,
    @Default('') String created_at,
    @Default('') String updated_at,

    /// author
    @Default('') String created_by,
    @Default('') String username,
    @Default('') String avatar_url,

    /// like
    @Default(false) bool is_like,
    @Default(0) int like_count,

    /// comment
    @Default(0) int comment_count,
  }) = _FetchFeedModel;

  factory FetchFeedModel.fromJson(Map<String, dynamic> json) =>
      _$FetchFeedModelFromJson(json);
}
