part of '../impl/private_chat_message.remote_datasource_impl.dart';

abstract interface class RemotePrivateChatMessageDataSource
    implements PrivateChatMessageDataSource<PrivateChatMessageModel> {
  @override
  Future<void> saveChatMessage(PrivateChatMessageModel model);
}
