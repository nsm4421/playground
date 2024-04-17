import 'package:hot_place/domain/model/chat/message/chat_message.model.dart';

import '../../../../domain/model/chat/message/chat_message.local_model.dart';

abstract interface class LocalChatMessageDataSource {
  Future<void> saveChatMessages(Iterable<LocalChatMessageModel> messages);

  Future<List<LocalChatMessageModel>> getChatMessages(String chatId,
      {int? take});
}

abstract interface class RemoteChatMessageDataSource {
  Stream<List<ChatMessageModel>> getChatMessageStream(String chatId);

  Future<String> createChatMessage(ChatMessageModel chat);

  Future<String> deleteChatMessageById(String messageId);
}
