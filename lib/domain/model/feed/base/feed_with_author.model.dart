import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/user/account.model.dart';

import '../../../../core/constant/dto.constant.dart';

part 'feed_with_author.model.freezed.dart';

part 'feed_with_author.model.g.dart';

@freezed
class FeedWithAuthorModel with _$FeedWithAuthorModel {
  const factory FeedWithAuthorModel({
    @Default('') String id,
    @Default('') String content,
    @Default('') String caption,
    @Default('') String media,
    @Default(MediaType.image) MediaType type,
    @Default(<String>[]) List<String> hashtags,
    @Default('') String createdAt,
    @Default(AccountModel()) AccountModel author,
  }) = _FeedWithAuthorModel;

  factory FeedWithAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$FeedWithAuthorModelFromJson(json);
}
