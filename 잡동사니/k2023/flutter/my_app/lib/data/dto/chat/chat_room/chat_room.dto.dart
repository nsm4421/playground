import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room.dto.freezed.dart';

part 'chat_room.dto.g.dart';

@freezed
class ChatRoomDto with _$ChatRoomDto {
  const factory ChatRoomDto({
    @Default('') String? chatRoomId,
    @Default('') String? chatRoomName,
    @Default(<String>[]) List<String> hashtags,
    @Default(<String>[]) List<String> uidList,
    @Default('') String? hostUid,
    DateTime? createdAt,
  }) = _ChatRoomDto;

  factory ChatRoomDto.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomDtoFromJson(json);
}
