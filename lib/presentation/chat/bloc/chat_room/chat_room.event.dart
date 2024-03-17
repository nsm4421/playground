import 'package:hot_place/domain/entity/chat/chat.entity.dart';

import '../../../../core/constant/message.constant.dart';

class ChatRoomEvent {}

class InitChatRoom extends ChatRoomEvent {
  final String chatId;

  InitChatRoom(this.chatId);
}

class SendMessage extends ChatRoomEvent {
  final String content;
  final MessageType? type;

  SendMessage({required this.content, this.type = MessageType.text});
}
