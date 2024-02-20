import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/features/app/constant/user.constant.dart';

part 'message.entity.freezed.dart';

@freezed
class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    String? id,
    String? chatId,
    Profile? sender,
    Profile? receiver,
    String? text,
    DateTime? createAt,
  }) = _MessageEntity;
}
