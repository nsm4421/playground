import 'package:my_app/data/dto/chat/chat_message/chat_message.dto.dart';
import 'package:my_app/domain/model/chat/chat_message/chat_message.model.dart';

extension ChatMessageDtoEx on ChatMessageDto {
  ChatMessageModel toModel() => ChatMessageModel(
      chatRoomId: chatRoomId,
      message: message,
      senderUid: senderUid,
      createdAt: createdAt);
}
