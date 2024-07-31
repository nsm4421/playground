import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../auth/data/model/account.model.dart';
import '../../../../emotion/data/model/emotion.model.dart';

part 'feed_comment_for_rpc.model.freezed.dart';

part 'feed_comment_for_rpc.model.g.dart';

@freezed
class FeedCommentModelForRpc with _$FeedCommentModelForRpc {
  const factory FeedCommentModelForRpc({
    @Default('') String id,
    @Default('') String feed_id,
    @Default('') String content,
    @Default(AccountModel()) AccountModel created_by,
    EmotionModel? emotion,
    DateTime? created_at,
  }) = _FeedCommentForRpcModel;

  factory FeedCommentModelForRpc.fromJson(Map<String, dynamic> json) =>
      _$FeedCommentModelForRpcFromJson(json);
}
