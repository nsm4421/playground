import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_comment.freezed.dart';

part 'fetch_comment.g.dart';

@freezed
class FetchCommentModel with _$FetchCommentModel {
  const factory FetchCommentModel({
    @Default('') String id,
    @Default('') String refererence_table,
    @Default('') String refererence_id,
    @Default('') String content,
    @Default('') String author_uid,
    @Default('') String author_username,
    @Default('') String author_avatar_url,
    @Default('') String created_at,
    @Default('') String updated_at,
  }) = _FetchCommentModel;

  factory FetchCommentModel.fromJson(Map<String, dynamic> json) =>
      _$FetchCommentModelFromJson(json);
}
