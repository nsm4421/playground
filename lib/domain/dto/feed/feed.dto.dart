import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/feed/feed.model.dart';

part 'feed.dto.freezed.dart';

part 'feed.dto.g.dart';

@freezed
class FeedDto with _$FeedDto {
  const factory FeedDto({
    @Default('') String fid,
    @Default('') String uid,
    @Default('') String profileImageUrl,
    @Default('') String content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
    DateTime? createdAt,
    @Default(<String>[]) List<String> likeUidList,
    @Default(<String>[]) List<String> cidList,
    @Default(0) int shareCount,
  }) = _FeedDto;

  factory FeedDto.fromJson(Map<String, dynamic> json) =>
      _$FeedDtoFromJson(json);
}

extension FeedDtoEx on FeedDto {
  FeedModel toModel() => FeedModel(
      fid: fid,
      uid: uid,
      profileImageUrl: profileImageUrl,
      content: content,
      hashtags: hashtags,
      images: images,
      createdAt: createdAt,
      likeCount: likeUidList.length,
      commentCount: cidList.length,
      shareCount: shareCount);
}
