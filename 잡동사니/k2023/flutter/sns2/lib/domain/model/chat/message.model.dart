import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/constant/chat.enum.dart';
import '../user/user.model.dart';

part 'message.model.freezed.dart';

part 'message.model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel(
      {String? messageId,
      String? chatId,
      MessageType? type,
      UserModel? sender,
      @Default(false) bool isMine,
      String? content,
      bool? isSeen,
      DateTime? createdAt}) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
