import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/domain/model/chat/chat_room/chat_room.model.dart';

import '../../../../../core/constant/enums/status.enum.dart';
import '../../../../../core/utils/exception/error_response.dart';

part 'chat_room.state.freezed.dart';

@freezed
class ChatRoomState with _$ChatRoomState {
  const factory ChatRoomState({
    @Default(Status.initial) Status status,
    @Default(<ChatRoomModel>[]) List<ChatRoomModel> chatRooms,
    @Default(ErrorResponse()) ErrorResponse error,
  }) = _ChatRoomState;
}
