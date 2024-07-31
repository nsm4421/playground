import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/emotion/data/model/emotion.model.dart';

import '../../../../auth/data/model/account.model.dart';

part 'feed_model_for_rpc.model.freezed.dart';
part 'feed_model_for_rpc.model.g.dart';

@freezed
class FeedModelForRpc with _$FeedModelForRpc {
  const factory FeedModelForRpc({
    @Default('') String id,
    @Default('') String content,
    @Default(<String>[]) List<String> media,
    @Default(<String>[]) List<String> hashtags,
    @Default(AccountModel()) AccountModel created_by,
    EmotionModel? emotion,
    DateTime? created_at,
  }) = _FeedModelForRpc;

  factory FeedModelForRpc.fromJson(Map<String, dynamic> json) =>
      _$FeedModelForRpcFromJson(json);
}