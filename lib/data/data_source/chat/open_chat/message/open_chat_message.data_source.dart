import 'package:hot_place/domain/model/chat/open_chat/message/open_chat_message.model.dart';

import '../../../../../domain/model/chat/open_chat/message/open_chat_message.local_model.dart';

abstract interface class LocalOpenChatMessageDataSource {
  Future<void> saveChatMessages(Iterable<LocalOpenChatMessageModel> messages);

  Future<List<LocalOpenChatMessageModel>> getChatMessages(String chatId,
      {int? take});
}

abstract interface class RemoteOpenChatMessageDataSource {
  Stream<List<OpenChatMessageModel>> getChatMessageStream(String chatId);

  Future<String> createChatMessage(OpenChatMessageModel chat);

  Future<String> deleteChatMessageById(String messageId);
}
