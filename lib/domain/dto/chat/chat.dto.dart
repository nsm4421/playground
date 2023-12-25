import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app/core/constant/chat.enum.dart';
import 'package:my_app/domain/model/chat/chat.model.dart';

part 'chat.dto.freezed.dart';

part 'chat.dto.g.dart';

@freezed
class ChatDto with _$ChatDto {
  const factory ChatDto(
      {@Default('') String chatId,
      @Default(ChatType.dm) ChatType type,
      @Default(<String>{}) Set<String> uidList,
      DateTime? createdAt}) = _ChatDto;

  factory ChatDto.fromJson(Map<String, dynamic> json) =>
      _$ChatDtoFromJson(json);
}

extension ChatDtoEx on ChatDto {
  ChatModel toModel() =>
      ChatModel(chatId: chatId, type: type, createdAt: createdAt);
}
