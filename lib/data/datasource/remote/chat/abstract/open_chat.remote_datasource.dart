part of "../impl/open_chat.remote_datasource_impl.dart";

abstract interface class OpenChatRemoteDataSource implements BaseRemoteDataSource<OpenChatModel>{
  Future<void> createChat(OpenChatModel chatRoom);

  Future<void> updateLastMessage(
      {required String chatId, required String lastMessage});

  Stream<Iterable<OpenChatModel>> get chatStream;

  Future<void> deleteChatById(String chatId);
}
