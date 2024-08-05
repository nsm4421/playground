import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'private_chat_message.model.freezed.dart';

part 'private_chat_message.model.g.dart';

@freezed
class PrivateChatMessageModel with _$PrivateChatMessageModel {
  const factory PrivateChatMessageModel(
      {@Default('') String id,
      @Default('') String chat_id,
      @Default('') String sender,
      @Default('') String receiver,
      @Default('') String content,
      DateTime? created_at}) = _PrivateChatMessageModel;

  factory PrivateChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$PrivateChatMessageModelFromJson(json);
}
