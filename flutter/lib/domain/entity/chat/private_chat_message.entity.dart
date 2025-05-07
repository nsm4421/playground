part of '../export.entity.dart';

class PrivateChatMessageEntity extends UuidIdEntity {
  final String content;
  final UserEntity sender;
  final UserEntity receiver;
  final DateTime? deletedAt;

  PrivateChatMessageEntity(
      {required super.id,
      required this.content,
      required this.sender,
      required this.receiver,
      super.createdAt,
      super.updatedAt,
      this.deletedAt});

  factory PrivateChatMessageEntity.from(PrivateChatMessageDto dto) {
    return PrivateChatMessageEntity(
        id: dto.id,
        content: dto.content,
        sender: UserEntity.from(dto.sender),
        receiver: UserEntity.from(dto.receiver),
        createdAt: DateTime.parse(dto.createdAt),
        updatedAt: DateTime.parse(dto.updatedAt),
        deletedAt:
            dto.deletedAt == null ? null : DateTime.parse(dto.deletedAt!));
  }
}
