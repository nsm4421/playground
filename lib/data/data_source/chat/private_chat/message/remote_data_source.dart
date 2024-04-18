import '../../../../../domain/model/chat/private_chat/message/private_chat_message.model.dart';

abstract interface class RemotePrivateChatMessageDataSource {
  Stream<List<PrivateChatMessageModel>> getChatMessageStream(String chatId);

  Future<void> createChatMessage(PrivateChatMessageModel chat);

  Future<void> deleteChatMessageById(String messageId);
}
