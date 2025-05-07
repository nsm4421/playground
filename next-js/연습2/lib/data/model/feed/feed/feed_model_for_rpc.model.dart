import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/constant/emotion_type.dart';

part 'feed_model_for_rpc.model.freezed.dart';

part 'feed_model_for_rpc.model.g.dart';

@freezed
class FeedModelForRpc with _$FeedModelForRpc {
  const factory FeedModelForRpc({
    @Default('') String id,
    @Default('') String content,
    @Default(<String>[]) List<String> media,
    @Default(<String>[]) List<String> hashtags,
    @Default('') String author_id,
    @Default('') String author_nickname,
    @Default('') String author_profile_image,
    String? emotion_id,
    EmotionType? emotion_type,
    DateTime? created_at,
  }) = _FeedModelForRpc;

  factory FeedModelForRpc.fromJson(Map<String, dynamic> json) =>
      _$FeedModelForRpcFromJson(json);
}
