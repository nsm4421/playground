part of 'package:portfolio/features/chat/data/repository_impl/open_chat_message.repository_impl.dart';

abstract class OpenChatMessageRepository {
  Future<ResponseWrapper<void>> createChatMessage(ChatMessageEntity entity);

  RealtimeChannel getMessageChannel({
    required String chatId,
    void Function(ChatMessageEntity newRecord)? onInsert,
    void Function(ChatMessageEntity oldRecord, ChatMessageEntity newRecord)?
        onUpdate,
    void Function(ChatMessageEntity oldRecord)? onDelete,
  });

  Future<ResponseWrapper<void>> deleteChatMessage(String messageId);
}
