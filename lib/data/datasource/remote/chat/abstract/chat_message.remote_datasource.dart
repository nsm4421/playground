import '../../../base/remote_datasource.dart';

abstract interface class ChatMessageRemoteDataSource<T>
    implements BaseRemoteDataSource<T> {
  Future<void> createChatMessage(T model);

  Future<void> deleteChatMessageById(String messageId);
}
