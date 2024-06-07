part of 'package:my_app/data/repository_impl/chat/chat.repository_impl.dart';

abstract interface class ChatRepository {
  Stream<List<ChatEntity>> getChatStream();

  Stream<List<ChatMessageEntity>> getMessageStream(String chatId);

  Future<Either<Failure, void>> sendChatMessage(ChatMessageEntity entity);

  Future<Either<Failure, void>> deleteChat(ChatEntity entity);

  Future<Either<Failure, void>> deleteChatMessage(ChatMessageEntity entity);
}
