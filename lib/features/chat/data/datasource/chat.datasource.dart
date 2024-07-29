import '../../../main/data/datasource/base.datasource.dart';

abstract interface class ChatDataSource<T> implements BaseDataSource {
  T audit(T model);

  Future<void> createChat(T chatRoom);

  Future<void> updateLastMessage(
      {required String chatId, required String lastMessage});

  Stream<Iterable<T>> get chatStream;

  Future<void> deleteChatById(String chatId);
}
