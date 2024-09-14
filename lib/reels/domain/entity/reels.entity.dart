import 'package:flutter/foundation.dart';
import 'package:flutter_app/reels/data/dto/fetch_reels.dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../auth/domain/domain.export.dart';

part 'reels.entity.freezed.dart';

@freezed
class ReelsEntity with _$ReelsEntity {
  const factory ReelsEntity({
    String? id,
    String? media,
    String? caption,
    String? createdAt,
    String? updatedAt,
    PresenceEntity? author,
  }) = _ReelsEntity;

  factory ReelsEntity.from(FetchReelsDto dto) {
    return ReelsEntity(
        id: dto.id.isNotEmpty ? dto.id : null,
        media: dto.media.isNotEmpty ? dto.media : null,
        caption: dto.caption.isNotEmpty ? dto.caption : null,
        createdAt: dto.created_at.isNotEmpty ? dto.created_at : null,
        updatedAt: dto.updated_at.isNotEmpty ? dto.created_at : null,
        author: PresenceEntity(
            uid: dto.author.id.isNotEmpty ? dto.author.id : null,
            username:
                dto.author.username.isNotEmpty ? dto.author.username : null,
            avatarUrl: dto.author.avatar_url.isNotEmpty
                ? dto.author.avatar_url
                : null));
  }
}
