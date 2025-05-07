part of '../export.entity.dart';

class GroupChatMessageEntity extends UuidIdEntity {
  final String chatId;
  final String content;
  final UserEntity sender;

  GroupChatMessageEntity(
      {required super.id,
      required this.sender,
      required this.chatId,
      required this.content,
      super.createdAt,
      super.updatedAt});

  factory GroupChatMessageEntity.from(GroupChatMessageDto dto) {
    return GroupChatMessageEntity(
      id: dto.id,
      sender: UserEntity.from(dto.creator),
      chatId: dto.chat.id,
      content: dto.content,
      createdAt: DateTime.parse(dto.createdAt),
      updatedAt: DateTime.parse(dto.updatedAt),
    );
  }
}
