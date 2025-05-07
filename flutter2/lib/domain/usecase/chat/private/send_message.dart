part of 'usecase.dart';

class SendMessageUseCase with CustomLogger {
  final PrivateChatRepository _chatRepository;
  final PrivateMessageRepository _messageRepository;

  SendMessageUseCase(
      {required PrivateChatRepository chatRepository,
      required PrivateMessageRepository messageRepository})
      : _chatRepository = chatRepository,
        _messageRepository = messageRepository;

  Future<Either<ErrorResponse, void>> call({
    required String chatId,
    required String messageId,
    required String receiverId,
    ChatTypes type = ChatTypes.text,
    required String content,
  }) async {
    try {
      // 메세지 데이터 생성
      await _messageRepository.create(
          messageId: messageId,
          chatId: chatId,
          receiverId: receiverId,
          type: type,
          content: content);
      // 채팅방 업데이트
      await _chatRepository.update(chatId: chatId, lastMessage: content);
      return const Right(null);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }
}
