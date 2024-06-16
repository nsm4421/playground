import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/core/constant/dto.constant.dart';

import '../../../../core/constant/status.dart';

part 'send_open_chat_message.state.freezed.dart';

@freezed
class SendOpenChatMessageState with _$SendOpenChatMessageState {
  const factory SendOpenChatMessageState({
    @Default(Status.initial) Status status,
    @Default('') String chatId,
    @Default('') String content,
    @Default(ChatMessageType.text) ChatMessageType type,
    String? errorMessage,
  }) = _SendOpenChatMessageState;
}
