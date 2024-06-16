part of 'package:my_app/data/repository_impl/chat/open_chat/open_chat_message.reopsitory_impl.dart';

abstract interface class OpenChatMessageRepository {
  RealtimeChannel getMessageChannel(
      {required String chatId,
      required PostgresChangeEvent changeEvent,
      required void Function(OpenChatMessageEntity? oldRecord,
              OpenChatMessageEntity? newRecord)
          callback});

  Future<Either<Failure, void>> saveChatMessage(OpenChatMessageEntity entity);

  Future<Either<Failure, void>> deleteMessageById(String messageId);
}
