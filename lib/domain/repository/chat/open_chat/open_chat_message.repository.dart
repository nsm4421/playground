part of 'package:my_app/data/repository_impl/chat/open_chat/open_chat_message.reopsitory_impl.dart';

abstract interface class OpenChatMessageRepository {
  RealtimeChannel getMessageChannel({
    required String chatId,
    required void Function(OpenChatMessageEntity entity) onInsert,
  });

  Future<Either<Failure, void>> saveChatMessage(OpenChatMessageEntity entity);

  Future<Either<Failure, void>> deleteMessageById(String messageId);
}
