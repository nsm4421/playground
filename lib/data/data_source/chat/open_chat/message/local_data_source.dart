import '../../../../../domain/model/chat/open_chat/message/open_chat_message.local_model.dart';

abstract interface class LocalOpenChatMessageDataSource {
  Future<void> saveChatMessages(Iterable<LocalOpenChatMessageModel> messages);

  Future<List<LocalOpenChatMessageModel>> getChatMessages(String chatId,
      {int? take});
}