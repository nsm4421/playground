import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/user/account.entity.dart';
import 'package:my_app/domain/model/feed/base/fetch_feed_response.dto.dart';
import 'package:my_app/domain/model/feed/base/save_feed_request.dto.dart';

import '../../../../core/constant/dto.constant.dart';

part 'feed.entity.freezed.dart';

part 'feed.entity.g.dart';

@freezed
class FeedEntity with _$FeedEntity {
  const factory FeedEntity({
    String? id,
    String? content,
    String? caption,
    String? media,
    @Default(MediaType.image) MediaType type,
    @Default(<String>[]) List<String> hashtags,
    DateTime? createdAt,
    AccountEntity? author,
  }) = _FeedEntity;

  factory FeedEntity.fromJson(Map<String, dynamic> json) =>
      _$FeedEntityFromJson(json);

  factory FeedEntity.fromFetchFeedResponseDto(FetchFeedResponseDto dto) =>
      FeedEntity(
          id: dto.id.isEmpty ? null : dto.id,
          content: dto.content.isEmpty ? null : dto.content,
          caption: dto.caption.isEmpty ? null : dto.caption,
          media: dto.media.isEmpty ? null : dto.media,
          type: dto.type,
          hashtags: dto.hashtags,
          createdAt: dto.createdAt,
          author: AccountEntity.fromDto(dto.author));
}
