import 'package:hive/hive.dart';
import 'package:hot_place/data/entity/chat/private_chat/message/private_chat_message.entity.dart';

part 'private_chat_message.local_model.g.dart';

@HiveType(typeId: 2)
class LocalPrivateChatMessageModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String chat_id;

  @HiveField(2)
  String sender_id;

  @HiveField(3)
  String sender_nickname;

  @HiveField(4)
  String sender_profile_image;

  @HiveField(5)
  String receiver_id;

  @HiveField(6)
  String receiver_nickanme;

  @HiveField(7)
  String receiver_profile_image;

  @HiveField(8)
  String content;

  @HiveField(9)
  bool is_seen = true;

  @HiveField(10)
  DateTime? created_at;

  LocalPrivateChatMessageModel(
      {required this.id,
      required this.chat_id,
      required this.sender_id,
      required this.sender_nickname,
      required this.sender_profile_image,
      required this.receiver_id,
      required this.receiver_nickanme,
      required this.receiver_profile_image,
      required this.content,
      required this.is_seen,
      this.created_at});

  factory LocalPrivateChatMessageModel.fromEntity(
          PrivateChatMessageEntity entity) =>
      LocalPrivateChatMessageModel(
          id: entity.id ?? '',
          chat_id: entity.chatId ?? '',
          sender_id: entity.sender?.id ?? '',
          sender_nickname: entity.sender?.nickname ?? '',
          sender_profile_image: entity.sender?.profileImage ?? '',
          receiver_id: entity.receiver?.id ?? '',
          receiver_nickanme: entity.receiver?.nickname ?? '',
          receiver_profile_image: entity.receiver?.profileImage ?? '',
          content: entity.content ?? '',
          is_seen: true,
          created_at: entity.createdAt);
}
