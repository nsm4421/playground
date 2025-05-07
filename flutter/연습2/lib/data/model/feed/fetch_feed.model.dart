import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:my_app/data/model/reaction/reaction.model.dart';

import '../auth/user.model.dart';


part 'fetch_feed.model.freezed.dart';

part 'fetch_feed.model.g.dart';

@freezed
class FeedDto with _$FeedDto {
  const factory FeedDto({
    @Default(0) int id,
    @Default('') String content,
    @Default(<String>[]) List<String> images,
    @Default(<String>[]) List<String> hashtags,
    @Default(UserModel()) UserModel creator,
    @Default([]) List<ReactionDto> reactions,
    @Default('') String createdAt,
    @Default('') String updatedAt,
  }) = _FeedDto;

  factory FeedDto.fromJson(Map<String, dynamic> json) =>
      _$FeedDtoFromJson(json);
}
