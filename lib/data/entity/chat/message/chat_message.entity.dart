import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/model/chat/message/chat_message.model.dart';
import '../../user/user.entity.dart';

part 'chat_message.entity.freezed.dart';

part 'chat_message.entity.g.dart';

@freezed
class ChatMessageEntity with _$ChatMessageEntity {
  const factory ChatMessageEntity({
    String? id,
    String? chatId,
    UserEntity? sender,
    String? content,
    DateTime? createdAt,
  }) = _ChatMessageEntity;

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageEntityFromJson(json);

  factory ChatMessageEntity.fromModel(
          ChatMessageModel model) =>
      ChatMessageEntity(
          id: model.id,
          chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
          sender: UserEntity(
              id: model.user_id,
              nickname: model.nickname,
              profileImage: model.profile_image),
          content: model.content.isNotEmpty ? model.content : null,
          createdAt: model.created_at);
}
