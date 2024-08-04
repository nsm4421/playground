import '../../base/base.datasource.dart';

abstract interface class ChatDataSource<T> implements BaseDataSource<T> {
  Future<void> createChat(T chatRoom);

  Future<void> updateLastMessage(
      {required String chatId, required String lastMessage});

  Stream<Iterable<T>> get chatStream;

  Future<void> deleteChatById(String chatId);
}
