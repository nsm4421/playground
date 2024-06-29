part of '../impl/open_chat_message.remote_datasource_impl.dart';

abstract interface class RemoteOpenChatMessageDataSource {
  RealtimeChannel getMessageChannel(
      {required String chatId,
      required void Function(PostgresChangePayload) onInsert});

  Future<void> saveChatMessage(OpenChatMessageModel model);

  Future<void> deleteMessageById(String messageId);
}
