import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hot_place/domain/entity/user/user.entity.dart';

import '../../../data/model/chat/chat.model.dart';

part 'chat.entity.freezed.dart';

part 'chat.entity.g.dart';

@freezed
class ChatEntity with _$ChatEntity {
  const factory ChatEntity({
    String? id,
    String? lastMessage,
    DateTime? createdAt,
    num? unReadCount,
    UserEntity? host,
    UserEntity? guest,
  }) = _ChatEntity;

  factory ChatEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatEntityFromJson(json);

  static fromModel({
    required ChatModel model,
    required UserEntity host,
    required UserEntity guest,
  }) =>
      ChatEntity(
        id: model.id,
        lastMessage: model.lastMessage,
        createdAt: model.createdAt,
        unReadCount: model.unReadCount,
        host: host,
        guest: guest,
      );
}

extension ChatEntityEx on ChatEntity {
  ChatModel toModel() => ChatModel(
        id: id ?? '',
        lastMessage: lastMessage ?? '',
        createdAt: createdAt,
        unReadCount: unReadCount ?? 0,
        hostUid: host?.uid ?? '',
        guestUid: guest?.uid ?? '',
      );
}
