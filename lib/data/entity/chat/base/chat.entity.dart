import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/core/constant/chat.dart';
import 'package:my_app/data/entity/chat/message/chat_message.entity.dart';

import '../../../../domain/model/chat/base/chat.model.dart';

part 'chat.entity.freezed.dart';

part 'chat.entity.g.dart';

@freezed
class ChatEntity with _$ChatEntity {
  const factory ChatEntity({
    String? id,
    String? uid,
    String? opponentUid,
    String? createdAt,
    String? lastTalkAt,
    ChatMessageEntity? lastMessage,
  }) = _ChatEntity;

  factory ChatEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatEntityFromJson(json);

  factory ChatEntity.fromModel(ChatModel model) => ChatEntity(
        id: model.id.isEmpty ? null : model.id,
        uid: model.uid.isEmpty ? null : model.uid,
        opponentUid: model.opponentUid.isEmpty ? null : model.opponentUid,
        createdAt: model.createdAt,
        lastTalkAt: model.lastTalkAt,
        lastMessage: model.lastMessage == null
            ? null
            : ChatMessageEntity.fromModel(model.lastMessage!),
      );
}
