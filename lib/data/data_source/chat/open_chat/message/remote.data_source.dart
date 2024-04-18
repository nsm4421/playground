import 'package:hot_place/domain/model/chat/open_chat/message/open_chat_message.model.dart';

abstract interface class RemoteOpenChatMessageDataSource {
  Stream<List<OpenChatMessageModel>> getChatMessageStream(String chatId);

  Future<String> createChatMessage(OpenChatMessageModel chat);

  Future<String> deleteChatMessageById(String messageId);
}
