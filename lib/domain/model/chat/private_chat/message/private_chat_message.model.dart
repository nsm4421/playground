import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/model/chat/private_chat/message/private_chat_message.local_model.dart';

import '../../../../../data/entity/chat/private_chat/message/private_chat_message.entity.dart';

part 'private_chat_message.model.freezed.dart';

part 'private_chat_message.model.g.dart';

@freezed
class PrivateChatMessageModel with _$PrivateChatMessageModel {
  const factory PrivateChatMessageModel({
    @Default('') String id,
    @Default('') String chat_id,
    @Default('') String sender_id,
    @Default('') String sender_nickname,
    @Default('') String sender_profile_image,
    @Default('') String receiver_id,
    @Default('') String receiver_nickname,
    @Default('') String receiver_profile_image,
    @Default('') String content,
    @Default(false) is_seen,
    DateTime? created_at,
  }) = _PrivateChatMessageModel;

  factory PrivateChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$PrivateChatMessageModelFromJson(json);

  factory PrivateChatMessageModel.fromEntity(PrivateChatMessageEntity entity) =>
      PrivateChatMessageModel(
          id: entity.id ?? '',
          chat_id: entity.chatId ?? '',
          sender_id: entity.sender?.id ?? '',
          sender_nickname: entity.sender?.nickname ?? '',
          sender_profile_image: entity.sender?.profileImage ?? '',
          receiver_id: entity.receiver?.id ?? '',
          receiver_nickname: entity.receiver?.nickname ?? '',
          receiver_profile_image: entity.receiver?.profileImage ?? '',
          content: entity.content ?? '',
          created_at: entity.createdAt);

  factory PrivateChatMessageModel.fromLocalModel(
          LocalPrivateChatMessageModel model) =>
      PrivateChatMessageModel(
          id: model.id,
          chat_id: model.chat_id,
          sender_id: model.sender_id,
          sender_nickname: model.sender_nickname,
          sender_profile_image: model.sender_profile_image,
          receiver_id: model.receiver_id,
          receiver_nickname: model.receiver_nickanme,
          receiver_profile_image: model.receiver_profile_image,
          content: model.content,
          created_at: model.created_at);
}
