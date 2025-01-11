part of '../export.entity.dart';

class FeedEntity extends IntIdEntity {
  final AuthorEntity author;
  final String content;
  late final List<String> hashtags;
  late final List<String> images;

  FeedEntity({
    required super.id,
    super.createdAt,
    super.updatedAt,
    required this.author,
    this.content = '',
    List<String>? hashtags,
    List<String>? images,
  }) {
    this.hashtags = hashtags ?? [];
    this.images = images ?? [];
  }

  factory FeedEntity.from(FeedDto dto) {
    return FeedEntity(
      id: dto.id,
      createdAt: DateTime.tryParse(dto.createdAt),
      updatedAt: DateTime.tryParse(dto.updatedAt),
      author: AuthorEntity.from(dto.author),
      content: dto.content,
      hashtags: dto.hashtags,
      images: dto.images,
    );
  }
}
