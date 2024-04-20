abstract interface class RemoteChatMessageDataSource<T> {
  Stream<List<T>> getChatMessageStream(String chatId);

  Future<String> createChatMessage(T chat);

  Future<String> deleteChatMessageById(String messageId);
}
