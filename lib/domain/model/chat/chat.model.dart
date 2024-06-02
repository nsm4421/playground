import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/data/entity/chat/chat.entity.dart';
import 'package:my_app/domain/model/chat/chat_message.model.dart';

part 'chat.model.freezed.dart';

part 'chat.model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel({
    @Default('') String id,
    @Default('') String uid,
    @Default('') String opponentUid,
    String? createdAt,
    String? lastTalkAt,
    ChatMessageModel? lastMessage,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  factory ChatModel.fromEntity(ChatEntity entity) => ChatModel(
        id: entity.id ?? '',
        uid: entity.uid ?? '',
        opponentUid: entity.opponentUid ?? '',
        lastTalkAt: entity.lastTalkAt,
        createdAt: entity.createdAt,
        lastMessage: entity.lastMessage == null
            ? null
            : ChatMessageModel.fromEntity(entity.lastMessage!),
      );
}

extension ChatModelEx on ChatModel {
  ChatModel get swap => this.copyWith(uid: opponentUid, opponentUid: uid);
}
