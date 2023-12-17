import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../dto/feed/feed.dto.dart';

part 'feed.model.freezed.dart';

part 'feed.model.g.dart';

@freezed
class FeedModel with _$FeedModel {
  const factory FeedModel({
    String? fid,
    String? uid,
    String? profileImageUrl,
    String? content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> images,
    DateTime? createdAt,
    int? likeCount,
    int? shareCount,
    int? commentCount,
  }) = _FeedModel;

  factory FeedModel.fromJson(Map<String, dynamic> json) =>
      _$FeedModelFromJson(json);
}

extension FeedModelEx on FeedModel {
  FeedDto toDto() => FeedDto(
      fid: fid ?? '',
      uid: uid ?? '',
      profileImageUrl: profileImageUrl ?? '',
      content: content ?? '',
      hashtags: hashtags ?? [],
      images: images ?? [],
      createdAt: createdAt,
      likeCount: likeCount ?? 0,
      shareCount: shareCount ?? 0,
      commentCount: commentCount ?? 0);
}
