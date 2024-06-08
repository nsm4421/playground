part of 'package:my_app/data/repository_impl/chat/chat_message.repository_impl.dart';

abstract interface class ChatMessageRepository {
  Stream<List<ChatMessageEntity>> getMessageStream(String chatId);

  Future<Either<Failure, void>> sendChatMessage(ChatMessageEntity entity);

  Future<Either<Failure, void>> deleteChatMessage(ChatMessageEntity entity);
}
