part of 'chat_datasource_impl.dart';

// TODO : 채널을 사용해 실시간 채팅 내용 업데이트

abstract class ChatDataSource {
  Future<FetchChatDto> findChatByUidOrElseCreate(String opponentUid);

  Future<FetchChatDto> findChatById(String chatId);

  // last_message_created_at이 before_at보다 작은 20개의 메세지를 가져옴
  Future<Iterable<FetchChatDto>> fetchChats(
      {required DateTime beforeAt, int take = 20});

  // created_at이 before_at보다 작은 20개의 메세지를 가져옴
  Future<Iterable<FetchChatMessageDto>> fetchMessages(
      {required String chatId, required DateTime beforeAt, int take = 20});

  Future<String> createChat(CreateChatDto dto);

  Future<void> createMessage(CreateChatMessageDto dto);

  Future<void> deleteChat(String chatId);

  Future<void> deleteMessageById(String messageId);

  Future<void> deleteMessageByChat(String chatId);

  Future<void> updateIsSeen(String messageId);
}
