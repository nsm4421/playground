import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.model.freezed.dart';

part 'chat.model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel({
    @Default('') String id,
    @Default('') String lastMessage,
    DateTime? createdAt,
    @Default(0) num unReadCount,
    @Default('') String hostUid,
    @Default('') String guestUid,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
