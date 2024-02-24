import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';

part 'chat.entity.freezed.dart';

@freezed
class ChatEntity with _$ChatEntity {
  const factory ChatEntity({
    @Default(UserEntity()) UserEntity sender,
    @Default(UserEntity()) UserEntity receiver,
    String? lastMessage,
    Timestamp? createdAt,
    num? unReadCount,
  }) = _ChatEntity;
}
