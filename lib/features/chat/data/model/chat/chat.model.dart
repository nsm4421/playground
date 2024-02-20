import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.model.freezed.dart';

part 'chat.model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel({
    String? id,
    String? uid,
    DateTime? enterAt,
    DateTime? lastSeenAt,
    String? lastMessage,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
