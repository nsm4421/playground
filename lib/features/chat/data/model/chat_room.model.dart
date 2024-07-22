import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room.model.freezed.dart';

part 'chat_room.model.g.dart';

@freezed
class ChatRoomModel with _$ChatRoomModel {
  const factory ChatRoomModel({
    @Default('') String id,
    String? last_message,
    DateTime? last_talk_at,
    @Default(<String>[]) List<String> uidList,
    DateTime? created_at,
  }) = _ChatRoomModel;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);
}
