import 'package:hive/hive.dart';
import 'package:hot_place/data/entity/chat/message/chat_message.entity.dart';

part 'chat_message.local_model.g.dart';

@HiveType(typeId: 1)
class LocalChatMessageModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String chat_id;

  @HiveField(2)
  String user_id;

  @HiveField(3)
  String nickname;

  @HiveField(4)
  String profile_image;

  @HiveField(5)
  String content;

  @HiveField(6)
  DateTime? created_at;

  LocalChatMessageModel(
      {required this.id,
      required this.chat_id,
      required this.user_id,
      required this.nickname,
      required this.profile_image,
      required this.content,
      this.created_at});

  factory LocalChatMessageModel.fromEntity(ChatMessageEntity entity) =>
      LocalChatMessageModel(
          id: entity.id ?? '',
          chat_id: entity.chatId ?? '',
          user_id: entity.sender?.id ?? '',
          nickname: entity.sender?.nickname ?? '',
          profile_image: entity.sender?.profileImage ?? '',
          content: entity.content ?? '',
          created_at: entity.createdAt);
}
