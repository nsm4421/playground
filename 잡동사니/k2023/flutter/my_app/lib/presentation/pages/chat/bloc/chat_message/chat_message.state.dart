import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/core/constant/enums/status.enum.dart';
import 'package:my_app/core/utils/exception/error_response.dart';
import 'package:my_app/domain/model/chat/chat_message/chat_message.model.dart';

part 'chat_message.state.freezed.dart';

@freezed
class ChatMessageState with _$ChatMessageState {
  const factory ChatMessageState({
    @Default(Status.initial) Status status,
    @Default(<ChatMessageModel>[]) List<ChatMessageModel> messages,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _ChatMessageState;
}
