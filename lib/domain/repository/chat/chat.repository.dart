import '../../entity/chat/chat.entity.dart';
import '../../entity/chat/message.entity.dart';

abstract class ChatRepository {
  Future<Stream<List<ChatEntity>>> getChatStream();

  Future<ChatEntity> findChatById(String chatId);

  Future<Stream<List<MessageEntity>>> getMessageStream(MessageEntity message);

  Future<void> sendMessage(MessageEntity message);

  Future<void> seenMessageUpdate(MessageEntity message);

  Future<void> deleteMessage(MessageEntity message);

  Future<void> deleteChat(ChatEntity chat);
}
