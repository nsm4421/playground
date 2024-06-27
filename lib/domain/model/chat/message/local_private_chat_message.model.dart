import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/data/entity/chat/chat_message/private_chat_message.entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constant/dto.constant.dart';

part 'local_private_chat_message.model.g.dart';

@HiveType(typeId: 0)
class LocalPrivateChatMessageModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime? createdAt;

  @HiveField(2)
  String senderUid;

  @HiveField(3)
  String receiverUid;

  @HiveField(4)
  String content;

  @HiveField(5)
  ChatMessageType type;

  LocalPrivateChatMessageModel({
    required this.id,
    required this.createdAt,
    required this.senderUid,
    required this.receiverUid,
    required this.content,
    required this.type,
  });

  static LocalPrivateChatMessageModel fromEntity(PrivateChatMessageEntity entity) =>
      LocalPrivateChatMessageModel(
        id: entity.id ?? const Uuid().v4(),
        createdAt: entity.createdAt ?? DateTime.now(),
        senderUid: entity.senderUid ?? '',
        receiverUid: entity.receiverUid ?? '',
        content: entity.content ?? '',
        type: entity.type,
      );
}
