part of "../../../data/repository_impl/chat/open_chat_message.repository_impl.dart";

abstract class OpenChatMessageRepository {
  Future<ResponseWrapper<List<OpenChatMessageEntity>>> fetchMessages(
      {required String chatId,
      required DateTime beforeAt,
      required int from,
      required int to,
      bool ascending = true});

  Future<ResponseWrapper<void>> createChatMessage(OpenChatMessageEntity entity);

  RealtimeChannel getMessageChannel({
    required String chatId,
    void Function(OpenChatMessageEntity newRecord)? onInsert,
    void Function(OpenChatMessageEntity oldRecord, OpenChatMessageEntity newRecord)?
        onUpdate,
    void Function(OpenChatMessageEntity oldRecord)? onDelete,
  });

  Future<ResponseWrapper<void>> deleteChatMessage(String messageId);
}
