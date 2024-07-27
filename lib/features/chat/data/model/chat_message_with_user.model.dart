import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/auth/data/model/account.model.dart';
import 'package:portfolio/features/chat/data/model/chat_message.model.dart';

part 'chat_message_with_user.model.freezed.dart';

part 'chat_message_with_user.model.g.dart';

@freezed
class ChatMessageWithUserModel with _$ChatMessageWithUserModel {
  const factory ChatMessageWithUserModel({
    @Default('') String id,
    @Default('') String chat_id,
    @Default('') String content,
    @Default('') String created_by,
    DateTime? created_at,
    @Default(AccountModel()) AccountModel user,
  }) = _ChatMessageWithUserModel;

  factory ChatMessageWithUserModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageWithUserModelFromJson(json);
}
