import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/core/constant/chat.constant.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/data/model/chat/fetch.dart';
import 'package:travel/domain/entity/auth/presence.dart';

class PrivateMessageEntity extends BaseEntity {
  final String chatId;
  final PresenceEntity sender;
  final PresenceEntity receiver;
  final String content;
  final ChatTypes type;
  final DateTime? deletedAt;

  PrivateMessageEntity({
    super.id,
    super.createdAt,
    super.updatedAt,
    required this.chatId,
    required this.sender,
    required this.receiver,
    required this.content,
    this.type = ChatTypes.text,
    this.deletedAt,
  });

  @override
  Tables get table => Tables.privateMessages;

  PrivateMessageEntity copyWith({
    String? chatId,
    PresenceEntity? sender,
    PresenceEntity? receiver,
    String? content,
    ChatTypes? type,
    DateTime? deletedAt,
  }) {
    return PrivateMessageEntity(
        id: id,
        createdAt: createdAt,
        updatedAt: deletedAt ?? createdAt,
        chatId: chatId ?? this.chatId,
        sender: sender ?? this.sender,
        receiver: receiver ?? this.receiver,
        content: content ?? this.content,
        type: type ?? this.type,
        deletedAt: deletedAt ?? this.deletedAt);
  }

  factory PrivateMessageEntity.from(FetchPrivateMessageDto dto) {
    return PrivateMessageEntity(
      id: dto.id,
      createdAt: DateTime.tryParse(dto.created_at),
      updatedAt: dto.deleted_at == null
          ? DateTime.tryParse(dto.created_at)
          : DateTime.tryParse(dto.deleted_at!),
      chatId: dto.chat_id,
      content: dto.content,
      sender: PresenceEntity(
        id: dto.sender_id,
        username: dto.sender_username,
        avatarUrl: dto.sender_avatar_url,
      ),
      receiver: PresenceEntity(
        id: dto.receiver_id,
        username: dto.receiver_username,
        avatarUrl: dto.receiver_avatar_url,
      ),
      deletedAt:
          dto.deleted_at == null ? null : DateTime.tryParse(dto.deleted_at!),
    );
  }
}
