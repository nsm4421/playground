import '../../../main/data/datasource/base.datasource.dart';

abstract interface class ChatMessageDataSource<T> implements BaseDataSource {
  Future<void> createChatMessage(T model);

  Future<void> deleteChatMessageById(String messageId);

  T audit(T model);
}
