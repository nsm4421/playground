import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/chat_room_model.g.dart';

part '../generated/chat_room_model.freezed.dart';

/**
 * 채팅방
 ** chatRoomId : 채팅방 id
 ** chatRoomName : 채팅방 이름
 ** host : 채팅방 host uid
 ** hashtags : 해새태그
 ** createdAt : 채팅방 개설시간
 ** removedAt : 채팅방 삭제시간
 */
@freezed
sealed class ChatRoomModel with _$ChatRoomModel {
  factory ChatRoomModel({
    String? chatRoomId,
    String? chatRoomName,
    String? host,
    String? hashtags,
    DateTime? createdAt,
    DateTime? removedAt,
  }) = _ChatRoomModel;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);
}
