part of 'repository.dart';

abstract interface class PrivateChatRepository {
  Future<Either<ErrorResponse, String?>> getChatId(String opponentId);

  Future<Either<ErrorResponse, String>> create(
      {required String chatId,
      required String userId,
      required String opponentId,
      String? lastMessage});

  Future<Either<ErrorResponse, List<PrivateChatEntity>>> fetch(
      {required String beforeAt, int take = 20});

  Future<Either<ErrorResponse, void>> update(
      {required String chatId, String? lastMessage, String? lastSeen});

  Future<Either<ErrorResponse, void>> delete(String chatId);
}

abstract interface class PrivateMessageRepository {
  Future<Either<ErrorResponse, void>> create({
    required String messageId,
    required String chatId,
    required String receiverId,
    required String content,
    ChatTypes type = ChatTypes.text,
  });

  Future<Either<ErrorResponse, List<PrivateMessageEntity>>> fetch(
      {required String beforeAt, required String chatId, int take = 20});

  Future<Either<ErrorResponse, void>> delete(String messageId);
}
