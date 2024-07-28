import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio/features/auth/data/model/account.model.dart';

part 'open_chat_message_with_user.model.freezed.dart';

part 'open_chat_message_with_user.model.g.dart';

@freezed
class OpenChatMessageWithUserModel with _$OpenChatMessageWithUserModel {
  const factory OpenChatMessageWithUserModel({
    @Default('') String id,
    @Default('') String chat_id,
    @Default('') String content,
    @Default('') String created_by,
    DateTime? created_at,
    @Default(AccountModel()) AccountModel user,
  }) = _OpenChatMessageWithUserModel;

  factory OpenChatMessageWithUserModel.fromJson(Map<String, dynamic> json) =>
      _$OpenChatMessageWithUserModelFromJson(json);
}
