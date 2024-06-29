part of '../impl/remote_open_chat.datasource_impl.dart';

abstract interface class RemoteOpenChatDataSource
    implements OpenChatDataSource {
  Stream<Iterable<OpenChatModel>> get chatStream;

  Future<void> saveChat(OpenChatModel model);

  Future<void> modifyChat(String chatId,
      {String? title, DateTime? lastTalkAt, String? lastMessage});

  Future<void> deleteChatById(String chatId);
}
