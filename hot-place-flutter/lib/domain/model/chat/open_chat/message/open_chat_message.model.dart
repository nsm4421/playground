import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data/entity/chat/open_chat/message/open_chat_message.entity.dart';

part 'open_chat_message.model.freezed.dart';

part 'open_chat_message.model.g.dart';

@freezed
class OpenChatMessageModel with _$OpenChatMessageModel {
  const factory OpenChatMessageModel(
      {@Default('') String id,
      @Default('') String chat_id,
      @Default('') String user_id,
      @Default('') String nickname,
      String? profile_image,
      @Default('') String content,
      DateTime? created_at}) = _OpenChatMessageModel;

  factory OpenChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$OpenChatMessageModelFromJson(json);

  factory OpenChatMessageModel.fromEntity(OpenChatMessageEntity entity) =>
      OpenChatMessageModel(
          id: entity.id ?? '',
          chat_id: entity.chatId ?? '',
          user_id: entity.sender!.id!,
          nickname: entity.sender?.nickname ?? '',
          profile_image: entity.sender?.profileImage,
          content: entity.content ?? '',
          created_at: entity.createdAt);
}
