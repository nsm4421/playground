import 'package:hot_place/features/chat/domain/entity/chat/chat.entity.dart';
import 'package:hot_place/features/chat/domain/entity/message/message.entity.dart';

abstract class ChatRepository {
  Stream<List<ChatEntity>> getChats();

  Future<void> leaveChat(ChatEntity chat);

  Future<void> sendMessage(MessageEntity message);

  Future<void> deleteMessage(MessageEntity message);
}
