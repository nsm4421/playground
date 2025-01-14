part of '../export.entity.dart';

class MessageEntity extends UuidIdEntity {
  final String chatId;
  final String content;
  final AuthorEntity sender;

  MessageEntity(
      {required super.id,
      required this.sender,
      required this.chatId,
      required this.content,
      super.createdAt,
      super.updatedAt});

  factory MessageEntity.from(MessageDto dto) {
    return MessageEntity(
      id: dto.id,
      sender: AuthorEntity.from(dto.creator),
      chatId: dto.chat.id,
      content: dto.content,
      createdAt: DateTime.parse(dto.createdAt),
      updatedAt: DateTime.parse(dto.updatedAt),
    );
  }
}
