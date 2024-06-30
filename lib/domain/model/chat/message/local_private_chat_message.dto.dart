import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/data/entity/chat/chat_message/private_chat_message.entity.dart';
import 'package:uuid/uuid.dart';

part 'local_private_chat_message.dto.g.dart';

@HiveType(typeId: 0)
class LocalPrivateChatMessageDto {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime? createdAt;

  @HiveField(2)
  String senderUid;

  @HiveField(3)
  String senderNickname;

  @HiveField(4)
  String senderProfileUrl;

  @HiveField(5)
  String receiverUid;

  @HiveField(6)
  String receiverNickname;

  @HiveField(7)
  String receiverProfileUrl;

  @HiveField(8)
  String content;

  @HiveField(9)
  String type;

  @HiveField(10)
  String chatId;

  @HiveField(11)
  bool isSuccess;

  LocalPrivateChatMessageDto(
      {required this.id,
        required this.createdAt,
        required this.senderUid,
        required this.senderNickname,
        required this.senderProfileUrl,
        required this.receiverUid,
        required this.receiverNickname,
        required this.receiverProfileUrl,
        required this.content,
        required this.type,
        required this.chatId,
        required this.isSuccess});

  factory LocalPrivateChatMessageDto.fromEntity(
      PrivateChatMessageEntity entity,
      {bool isSuccess = true}) =>
      LocalPrivateChatMessageDto(
          id: entity.id ?? const Uuid().v4(),
          createdAt: entity.createdAt ?? DateTime.now(),
          senderUid: entity.sender?.id ?? '',
          senderNickname: entity.sender?.nickname ?? '',
          senderProfileUrl: entity.sender?.profileUrl ?? '',
          receiverUid: entity.receiver?.id ?? '',
          receiverNickname: entity.receiver?.nickname ?? '',
          receiverProfileUrl: entity.receiver?.profileUrl ?? '',
          content: entity.content ?? '',
          type: entity.type.name,
          chatId: entity.chatId ?? '',
          isSuccess: isSuccess);
}
