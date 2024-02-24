import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/features/chat/domain/entity/message/message.entity.dart';

import '../../../../app/constant/user.constant.dart';

part 'chat.entity.freezed.dart';

@freezed
class ChatEntity with _$ChatEntity {
  const factory ChatEntity({
    String? id,
    @Default([]) List<Profile> users,
    DateTime? enterAt,
    DateTime? lastSeenAt,
    String? lastMessage,
    @Default(0) int unReadCount,
  }) = _ChatEntity;
}
