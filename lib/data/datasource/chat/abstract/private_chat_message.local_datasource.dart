part of '../impl/private_chat_message.local_datasource_impl.dart';

abstract interface class LocalPrivateChatMessageDataSource {
  Future<void> saveChatMessage(LocalPrivateChatMessageDto dto);

  Future<List<LocalPrivateChatMessageDto>> fetchLastMessages();

  Future<Iterable<LocalPrivateChatMessageDto>> fetchMessagesByUser(
      String opponentUid);

  Future<void> deleteMessageById(String messageId);
}
