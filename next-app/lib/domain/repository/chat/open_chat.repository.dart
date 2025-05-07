part of "../../../data/repository_impl/chat/open_chat.repository_impl.dart";

abstract class OpenChatRepository {
  Stream<List<OpenChatEntity>> get chatStream;

  Future<ResponseWrapper<void>> createChat(OpenChatEntity chat);

  Future<ResponseWrapper<void>> updateLastMessage(
      {required String chatId, required String lastMessage});
}
