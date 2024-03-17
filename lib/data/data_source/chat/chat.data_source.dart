import '../../model/chat/chat.model.dart';
import '../../model/chat/message.model.dart';

abstract class ChatDataSource {
  /// stream 가져오기
  Stream<List<ChatModel>> getChatStream();

  Stream<List<MessageModel>> getMessageStream(String chatId);

  /// id로 단건 조회
  Future<ChatModel> findChatById(String chatId);

  Future<MessageModel> findMessageById(
      {required String chatId, required String messageId});

  /// Create
  Future<String> createChat(ChatModel chat);

  Future<String> createMessage(MessageModel message);

  /// Read
  /// Update
  Future<void> seenMessageUpdate(
      {required String chatId, required String messageId});

  /// Delete
  Future<String> deleteChatById(String chatId);

  Future<String> deleteMessage(MessageModel message);
}
