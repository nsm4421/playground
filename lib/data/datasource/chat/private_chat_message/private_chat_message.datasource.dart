part of 'private_chat_message.datasource_impl.dart';

abstract interface class PrivateChatMessageDataSource<T> {
  Future<void> saveChatMessage(T model);

  Future<void> deleteMessageById(String messageId);
}

abstract interface class LocalPrivateChatMessageDataSource
    implements PrivateChatMessageDataSource<LocalPrivateChatMessageModel> {
  @override
  Future<void> saveChatMessage(LocalPrivateChatMessageModel model);
}

abstract interface class RemotePrivateChatMessageDataSource
    implements PrivateChatMessageDataSource<PrivateChatMessageModel> {
  @override
  Future<void> saveChatMessage(PrivateChatMessageModel model);
}
