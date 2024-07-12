abstract interface class RemoteChatDataSource<T> {
  Stream<List<T>> getChatStream();

  Future<void> createChat(T chat);

  Future<void> deleteChatById(String openChatId);
}
