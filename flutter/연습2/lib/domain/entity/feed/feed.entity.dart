part of '../export.entity.dart';

class FeedEntity extends IntIdEntity {
  final UserEntity author;
  final String content;
  late final List<String> hashtags;
  late final List<String> images;
  final ReactionEntity? reaction;

  FeedEntity(
      {required super.id,
      super.createdAt,
      super.updatedAt,
      required this.author,
      this.content = '',
      List<String>? hashtags,
      List<String>? images,
      this.reaction}) {
    this.hashtags = hashtags ?? [];
    this.images = images ?? [];
  }

  factory FeedEntity.from(FeedDto dto) {
    return FeedEntity(
        id: dto.id,
        createdAt: DateTime.tryParse(dto.createdAt),
        updatedAt: DateTime.tryParse(dto.updatedAt),
        author: UserEntity.from(dto.creator),
        content: dto.content,
        hashtags: dto.hashtags,
        images: dto.images.map((item) => '${ApiEndPoint.domain}$item').toList(),
        reaction: dto.reactions.isEmpty
            ? null
            : ReactionEntity.from(dto.reactions.first));
  }
}
