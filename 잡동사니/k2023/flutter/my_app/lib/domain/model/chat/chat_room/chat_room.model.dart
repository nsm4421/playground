import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room.model.freezed.dart';

part 'chat_room.model.g.dart';

@freezed
class ChatRoomModel with _$ChatRoomModel {
  const factory ChatRoomModel(
      {required String? chatRoomId,
      required String? chatRoomName,
      required List<String> hashtags,
      required List<String> uidList,
      required String? hostUid,
      DateTime? createdAt}) = _ChatRoomModel;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);
}
