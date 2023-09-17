import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/message_model.g.dart';

part '../generated/message_model.freezed.dart';

/**
 * 메세지
 ** messageId
 ** chatRoomId : 채팅방 id
 ** senderUid : 유저 id
 ** receiverUid : 유저명
 ** message : 메세지
 ** image : 이미지 링크
 ** createdAt : 메세지 작성시간
 ** removedAt : 메세지 삭제시간
 */
@freezed
sealed class MessageModel with _$MessageModel {
  factory MessageModel(
      {
        String? messageId,
        String? chatRoomId,
        String? senderUid,
        String? receiverUid,
        String? message,
        String? image,
        DateTime? createdAt,
        DateTime? removedAt,
      }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
