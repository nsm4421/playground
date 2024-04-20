abstract interface class LocalChatDataSource<T> {
  Future<void> saveChat(T chat);

  Future<void> deleteChatById(String chatId);
}
