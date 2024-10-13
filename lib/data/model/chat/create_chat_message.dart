import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_chat_message.freezed.dart';

part 'create_chat_message.g.dart';

@freezed
class CreateOpenChatMessageModel with _$CreateOpenChatMessageModel {
  const factory CreateOpenChatMessageModel({
    @Default('') String chat_id,
    @Default('') String content,
    String? media
  }) = _CreateOpenChatMessageModel;

  factory CreateOpenChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOpenChatMessageModelFromJson(json);
}

@freezed
class CreatePrivateChatMessageModel with _$CreatePrivateChatMessageModel {
  const factory CreatePrivateChatMessageModel({
    @Default('') String chat_id,
    @Default('') String sender,
    @Default('') String receiver,
    @Default('') String content,
    String? media,
  }) = _CreatePrivateChatMessageModel;

  factory CreatePrivateChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePrivateChatMessageModelFromJson(json);
}
