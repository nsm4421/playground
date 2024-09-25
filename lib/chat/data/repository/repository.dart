part of 'repository_impl.dart';

abstract class ChatRepository {
  Future<ResponseWrapper<void>> createChat({
    required String currentUid,
    required String opponentUid,
  });

  Future<ResponseWrapper<void>> createChatMessage({
    required String chatId,
    required ChatMessageType type,
    required String content,
    required String currentUid,
    required String opponentUid,
  });

  Future<ResponseWrapper<List<ChatEntity>>> fetchChats(
      {required DateTime beforeAt, int take = 20});

  Future<ResponseWrapper<List<ChatMessageEntity>>> fetchChatMessages(
      {required String chatId, required DateTime beforeAt, int take = 20});

  Future<ResponseWrapper<void>> deleteChat(String chatId);

  Future<ResponseWrapper<void>> deleteChatMessage(String messageId);
}
