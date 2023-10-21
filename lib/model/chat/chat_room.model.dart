import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room.model.freezed.dart';

part 'chat_room.model.g.dart';

@freezed
class ChatRoomModel with _$ChatRoomModel {
  const factory ChatRoomModel({
    @Default('') String? chatRoomId,
    @Default('') String? chatRoomName,
    @Default('') String? hostUserId,
    @Default(<String>[]) List<String> hashtags,
    DateTime? createdAt,
    DateTime? removedAt,
  }) = _ChatRoomModel;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);
}
