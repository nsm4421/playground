import '../../model/chat/chat.model.dart';
import '../../model/chat/message.model.dart';

abstract class ChatDataSource {
  Stream<List<ChatModel>> getChatStream();

  Stream<List<MessageModel>> getMessageStream(String chatId);

  Future<void> createChat(ChatModel chat);

  Future<void> createMessage(MessageModel message);

  Future<void> seenMessageUpdate(MessageModel message);

  Future<void> deleteChat(ChatModel chat);

  Future<void> deleteMessage(MessageModel message);
}
