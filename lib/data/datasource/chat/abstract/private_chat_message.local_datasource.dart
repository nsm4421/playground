part of '../impl/private_chat_message.local_datasource_impl.dart';

abstract interface class LocalPrivateChatMessageDataSource
    implements PrivateChatMessageDataSource<LocalPrivateChatMessageModel> {
  Future<List<LocalPrivateChatMessageModel>> fetchLastMessages();

  Future<Iterable<LocalPrivateChatMessageModel>> fetchMessagesByUser(
      String opponentUid);
}
