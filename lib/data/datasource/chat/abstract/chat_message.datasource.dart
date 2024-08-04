import '../../base/base.datasource.dart';

abstract interface class ChatMessageDataSource<T> implements BaseDataSource<T> {
  Future<void> createChatMessage(T model);

  Future<void> deleteChatMessageById(String messageId);
}
