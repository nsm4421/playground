import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/data/model/reels/fetch.dart';
import 'package:travel/domain/entity/auth/presence.dart';

class ReelsEntity extends BaseEntity {
  final String video;
  final String? caption;
  final PresenceEntity author;

  ReelsEntity(
      {super.id,
      super.createdAt,
      super.updatedAt,
      required this.video,
      this.caption,
      required this.author});

  factory ReelsEntity.from(FetchReelsDto dto) {
    return ReelsEntity(
      caption: dto.caption,
      video: dto.video,
      id: dto.id,
      createdAt: DateTime.tryParse(dto.created_at),
      updatedAt: DateTime.tryParse(dto.updated_at),
      author: PresenceEntity(
        id: dto.author_id,
        username: dto.author_username,
        avatarUrl: dto.author_avatar_url,
      ),
    );
  }
}
