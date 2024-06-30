part of '../impl/private_chat_message.remote_datasource_impl.dart';

abstract interface class RemotePrivateChatMessageDataSource {
  Future<void> saveChatMessage(SavePrivateChatMessageRequestDto dto);

  Future<void> deleteMessageById(String messageId);
}
