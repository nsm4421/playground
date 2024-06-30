import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/constant/dto.constant.dart';
import '../../../../../core/constant/status.dart';

part 'send_private_chat_message.state.freezed.dart';

@freezed
class SendPrivateChatMessageState with _$SendPrivateChatMessageState {
  const factory SendPrivateChatMessageState({
    @Default(Status.initial) Status status,
    @Default('') String content,
    @Default(ChatMessageType.text) ChatMessageType type,
    String? errorMessage,
  }) = _SendPrivateChatMessageState;
}
