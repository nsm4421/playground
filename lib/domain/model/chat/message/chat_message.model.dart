import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/data/entity/chat/message/chat_message.entity.dart';

part 'chat_message.model.freezed.dart';

part 'chat_message.model.g.dart';

@freezed
class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel(
      {@Default('') String id,
      @Default('') String chat_id,
      @Default('') String user_id,
      @Default('') String nickname,
      String? profile_image,
      @Default('') String content,
      DateTime? created_at}) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) =>
      ChatMessageModel(
          id: entity.id ?? '',
          chat_id: entity.chatId ?? '',
          user_id: entity.sender!.id!,
          nickname: entity.sender?.nickname ?? '',
          profile_image: entity.sender?.profileImage,
          content: entity.content ?? '',
          created_at: entity.createdAt);
}
