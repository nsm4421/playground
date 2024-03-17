import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/entity/chat/message.entity.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';

import '../../../../core/constant/response.constant.dart';

part 'chat_room.state.freezed.dart';

@freezed
class ChatRoomState with _$ChatRoomState {
  const factory ChatRoomState({
    @Default(Status.loading) Status status,
    @Default('') String chatId,
    @Default(UserEntity()) UserEntity opponent,
    Stream<List<MessageEntity>>? stream,
  }) = _ChatRoomState;
}
