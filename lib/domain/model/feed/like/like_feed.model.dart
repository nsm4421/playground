import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_feed.model.freezed.dart';

part 'like_feed.model.g.dart';

@freezed
class LikeFeedModel with _$LikeFeedModel {
  const factory LikeFeedModel({
    @Default('') String id,
    @Default('') String user_id,
    @Default('') String feed_id,
  }) = _LikeFeedModel;

  factory LikeFeedModel.fromJson(Map<String, dynamic> json) =>
      _$LikeFeedModelFromJson(json);
}
