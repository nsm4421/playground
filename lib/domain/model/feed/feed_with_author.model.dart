import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/model/user/user.model.dart';

part 'feed_with_author.model.freezed.dart';

part 'feed_with_author.model.g.dart';

@freezed
class FeedWithAuthorModel with _$FeedWithAuthorModel {
  const factory FeedWithAuthorModel({
    @Default('') String id,
    @Default(UserModel()) UserModel author,
    @Default('') String content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
    @Default(0) int num_like,
    DateTime? created_at,
  }) = _FeedWithAuthorModel;

  factory FeedWithAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$FeedWithAuthorModelFromJson(json);
}
