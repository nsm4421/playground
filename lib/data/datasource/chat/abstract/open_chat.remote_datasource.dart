part of '../impl/open_chat.remote_datasource_impl.dart';

abstract interface class RemoteOpenChatDataSource {
  Stream<Iterable<OpenChatModel>> get chatStream;

  Future<void> saveChat(OpenChatModel model);

  Future<void> modifyChat(String chatId,
      {String? title, DateTime? lastTalkAt, String? lastMessage});

  Future<void> deleteChatById(String chatId);
}
