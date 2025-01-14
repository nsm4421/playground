part of '../export.entity.dart';

class GroupChatEntity extends UuidIdEntity {
  final String title;
  late final List<String> hashtags;
  final AuthorEntity author;

  GroupChatEntity(
      {required super.id,
      required this.title,
      List<String>? hashtags,
      required this.author,
      super.createdAt,
      super.updatedAt}) {
    this.hashtags = hashtags ?? [];
  }

  factory GroupChatEntity.from(GroupChatDto dto) {
    return GroupChatEntity(
      id: dto.id,
      title: dto.title,
      hashtags: dto.hashtags,
      author: AuthorEntity.from(dto.creator),
      createdAt: DateTime.tryParse(dto.createdAt),
      updatedAt: DateTime.tryParse(dto.updatedAt),
    );
  }
}
