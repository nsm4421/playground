abstract interface class PrivateChatMessageDataSource<T> {
  Future<void> saveChatMessage(T model);

  Future<void> deleteMessageById(String messageId);
}