import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/model/chat/open_chat/message/open_chat_message.local_model.dart';
import '../../../../../domain/model/chat/open_chat/message/open_chat_message.model.dart';
import '../../../user/user.entity.dart';

part 'open_chat_message.entity.freezed.dart';

@freezed
class OpenChatMessageEntity with _$OpenChatMessageEntity {
  const factory OpenChatMessageEntity({
    String? id,
    String? chatId,
    UserEntity? sender,
    String? content,
    DateTime? createdAt,
  }) = _OpenChatMessageEntity;

  factory OpenChatMessageEntity.fromModel(OpenChatMessageModel model) =>
      OpenChatMessageEntity(
          id: model.id,
          chatId: model.chat_id.isNotEmpty ? model.chat_id : null,
          sender: UserEntity(
              id: model.user_id,
              nickname: model.nickname,
              profileImage: model.profile_image),
          content: model.content.isNotEmpty ? model.content : null,
          createdAt: model.created_at);

  factory OpenChatMessageEntity.fromLocalModel(
          LocalOpenChatMessageModel localModel) =>
      OpenChatMessageEntity(
          id: localModel.id,
          chatId: localModel.chat_id.isNotEmpty ? localModel.chat_id : null,
          sender: UserEntity(
              id: localModel.user_id,
              nickname: localModel.nickname,
              profileImage: localModel.profile_image),
          content: localModel.content.isNotEmpty ? localModel.content : null,
          createdAt: localModel.created_at);
}
