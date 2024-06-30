part of '../impl/open_chat_message.remote_datasource_impl.dart';

abstract interface class RemoteOpenChatMessageDataSource {
  RealtimeChannel getMessageChannel(
      {required String chatId,
      required void Function(PostgresChangePayload) onInsert});

  Future<void> saveChatMessage(SaveOpenChatMessageRequestDto dto);

  Future<void> deleteMessageById(String messageId);
}
