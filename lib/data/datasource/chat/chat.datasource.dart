import 'package:my_app/domain/model/chat/chat.model.dart';
import 'package:my_app/domain/model/chat/chat_message.model.dart';

abstract interface class ChatDataSource {}

abstract interface class LocalChatDataSource implements ChatDataSource {}

abstract interface class RemoteChatDataSource implements ChatDataSource {
  Stream<Iterable<ChatModel>> getChatStream();

  Stream<Iterable<ChatMessageModel>> getMessageStream(String chatId);

  Future<void> saveChat(ChatModel model);

  Future<void> saveChatMessage(ChatMessageModel model);

  Future<void> updateLastMessage(ChatMessageModel model);

  Future<void> deleteChat(ChatModel model);

  Future<void> deleteChatMessage(ChatMessageModel model);
}
