import 'package:hot_place/domain/model/chat/message/chat_message.model.dart';

abstract interface class LocalChatMessageDataSource {}

abstract interface class RemoteChatMessageDataSource {
  Stream<List<ChatMessageModel>> getChatMessageStream(String chatId);

  Future<String> createChatMessage(ChatMessageModel chat);

  Future<String> deleteChatMessageById(String messageId);
}
