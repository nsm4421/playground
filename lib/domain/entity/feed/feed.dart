import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/data/model/feed/fetch.dart';
import 'package:travel/domain/entity/auth/presence.dart';

class FeedEntity extends BaseEntity {
  late final List<String> hashtags;
  late final List<String> images;
  late final List<String> captions;
  final PresenceEntity author;

  FeedEntity(
      {super.id,
      super.createdAt,
      super.updatedAt,
      List<String>? hashtags,
      List<String>? images,
      List<String>? captions,
      required this.author}) {
    this.hashtags = hashtags ?? [];
    this.images = images ?? [];
    this.captions = captions ?? [];
  }

  factory FeedEntity.from(FetchFeedDto dto) {
    return FeedEntity(
      id: dto.id,
      createdAt: DateTime.tryParse(dto.created_at),
      updatedAt: DateTime.tryParse(dto.updated_at),
      hashtags: dto.hashtags,
      images: dto.images,
      captions: dto.captions,
      author: PresenceEntity(
        id: dto.author_id,
        username: dto.author_username,
        avatarUrl: dto.author_avatar_url,
      ),
    );
  }
}
