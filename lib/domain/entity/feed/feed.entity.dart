part of '../export.entity.dart';

class FeedEntity extends IntIdEntity {
  final String content;
  late final List<String> hashtags;

  FeedEntity({
    required super.id,
    super.createdAt,
    super.updatedAt,
    this.content = '',
    List<String>? hashtags,
  }) {
    this.hashtags = hashtags ?? [];
  }

  factory FeedEntity.from(FeedDto dto) {
    return FeedEntity(
      id: dto.id,
      content: dto.content,
      hashtags: dto.hashtags,
      createdAt: DateTime.tryParse(dto.createdAt),
      updatedAt: DateTime.tryParse(dto.updatedAt),
    );
  }
}
