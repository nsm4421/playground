import '../../entity/chat/chat.entity.dart';
import '../../entity/chat/message.entity.dart';

abstract class ChatRepository {
  Stream<List<ChatEntity>> getChatStream(ChatEntity chat);

  Stream<List<MessageEntity>> getMessageStream(MessageEntity message);

  Future<void> createChat(ChatEntity chat);

  Future<void> sendMessage(MessageEntity message);

  Future<void> seenMessageUpdate(MessageEntity message);

  Future<void> deleteMessage(MessageEntity message);

  Future<void> deleteChat(ChatEntity chat);
}
