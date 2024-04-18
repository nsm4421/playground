import '../../../../../domain/model/chat/private_chat/message/private_chat_message.model.dart';

abstract interface class LocalPrivateChatMessageDataSource {
  Future<void> saveChatMessages(Iterable<PrivateChatMessageModel> messages);

  Future<List<PrivateChatMessageModel>> getChatMessages(String chatId,
      {int? take});
}