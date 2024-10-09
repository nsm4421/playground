import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/model/diary/fetch_diary.dart';
import '../auth/presence.dart';

part 'diary.freezed.dart';

@freezed
class DiaryEntity with _$DiaryEntity {
  const factory DiaryEntity({
    String? id,
    String? location,
    String? content,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String?>[]) List<String?> images,
    @Default(<String?>[]) List<String?> captions,
    bool? isPrivate,
    DateTime? createdAt,
    DateTime? updatedAt,
    PresenceEntity? author,
  }) = _DiaryEntity;

  factory DiaryEntity.from(FetchDiaryModel model) => DiaryEntity(
      id: model.id.isNotEmpty ? model.id : null,
      location: model.location,
      content: model.content,
      hashtags: model.hashtags.where((item) => item.isNotEmpty).toList(),
      images:
          model.images.map((item) => item.isNotEmpty ? item : null).toList(),
      captions:
          model.captions.map((item) => item.isNotEmpty ? item : null).toList(),
      isPrivate: model.is_private,
      createdAt: DateTime.tryParse(model.created_at),
      updatedAt: DateTime.tryParse(model.updated_at),
      author: model.created_by.isNotEmpty
          ? PresenceEntity(
              uid: model.created_by,
              username: model.username,
              avatarUrl: model.avatar_url,
            )
          : null);
}

extension DiaryEntityExt on DiaryEntity {
  int get length => images?.length ?? 0;
}
