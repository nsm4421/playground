abstract interface class RemoteChatMessageDataSource<T> {
  Stream<List<T>> getChatMessageStream(String chatId);

  Future<void> createChatMessage(T message);

  Future<String> deleteChatMessageById(String messageId);
}
