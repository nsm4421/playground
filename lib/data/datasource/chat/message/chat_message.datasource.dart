part of 'chat_message.datasource_impl.dart';

abstract interface class ChatMessageDataSource {}

abstract interface class LocalChatMessageDataSource
    implements ChatMessageDataSource {}

abstract interface class RemoteChatMessageDataSource
    implements ChatMessageDataSource {
  Stream<Iterable<ChatMessageModel>> getChatMessageStream(String chatId);

  Future<void> saveChatMessage(ChatMessageModel model);

  Future<void> deleteChatMessage(ChatMessageModel model);
}
