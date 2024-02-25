import '../../model/chat/chat.model.dart';
import '../../model/chat/message.model.dart';

abstract class ChatDataSource {
  Stream<List<ChatModel>> getChatStream();

  Stream<List<MessageModel>> getMessageStream(String chatId);

  Future<ChatModel> findChatById(String chatId);

  Future<String> createChat(ChatModel chat);

  Future<String> createMessage(MessageModel message);

  Future<void> seenMessageUpdate(MessageModel message);

  Future<String> deleteChat(ChatModel chat);

  Future<String> deleteMessage(MessageModel message);
}
