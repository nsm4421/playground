import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constant/emotion_type.dart';

part 'feed_comment_for_rpc.model.freezed.dart';

part 'feed_comment_for_rpc.model.g.dart';

@freezed
class FeedCommentModelForRpc with _$FeedCommentModelForRpc {
  const factory FeedCommentModelForRpc(
      {@Default('') String id,
      @Default('') String feed_id,
      @Default('') String content,
      @Default('') String author_id,
      @Default('') String author_nickname,
      @Default('') String author_profile_image,
      DateTime? created_at,
      @Default('') emotion_id,
      EmotionType? emotion_type}) = _FeedCommentForRpcModel;

  factory FeedCommentModelForRpc.fromJson(Map<String, dynamic> json) =>
      _$FeedCommentModelForRpcFromJson(json);
}
