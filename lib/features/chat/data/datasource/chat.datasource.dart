abstract interface class ChatRoomDataSource<T> {
  Future<void> createChat(T chatRoom);
}
