import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constant/dto.constant.dart';

part 'local_private_chat_message.model.g.dart';

@HiveType(typeId: 1)
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
}
