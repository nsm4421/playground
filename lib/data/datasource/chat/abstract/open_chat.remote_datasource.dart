part of '../impl/open_chat.remote_datasource_impl.dart';

abstract interface class RemoteOpenChatDataSource {
  Stream<Iterable<FetchOpenChatResponseDto>> get chatStream;

  Future<void> saveChat(SaveOpenChatRequestDto dto);

  Future<void> modifyChat(ModifyOpenChatRequestDto dto);

  Future<void> deleteChatById(String chatId);
}
