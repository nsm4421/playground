part of '../export.entity.dart';

class CommentEntity extends IntIdEntity {
  final UserEntity author;
  final String content;

  CommentEntity(
      {super.createdAt,
      super.updatedAt,
      required super.id,
      required this.author,
      this.content = ''});

  factory CommentEntity.from(CommentDto dto) {
    return CommentEntity(
      id: dto.id,
      content: dto.content,
      author: UserEntity.from(dto.creator),
      createdAt: DateTime.parse(dto.createdAt),
      updatedAt: DateTime.parse(dto.updatedAt),
    );
  }

  CommentEntity copyWith({
    String? content,
    UserEntity? author,
  }) {
    return CommentEntity(
        id: id,
        content: content ?? this.content,
        author: author ?? this.author,
        createdAt: createdAt,
        updatedAt: updatedAt);
  }
}
