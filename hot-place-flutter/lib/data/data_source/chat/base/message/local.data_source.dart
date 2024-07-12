abstract interface class LocalChatMessageDataSource<T> {
  Future<void> saveChatMessages(Iterable<T> messages);

  Future<List<T>> getChatMessages(String chatId, {int? take});

  Future<void> deleteChatMessageById(String messageId);
}
