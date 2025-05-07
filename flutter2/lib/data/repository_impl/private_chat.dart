part of 'repository_impl.dart';

@LazySingleton(as: PrivateChatRepository)
class PrivateChatRepositoryImpl
    with CustomLogger
    implements PrivateChatRepository {
  final PrivateChatDataSource _dataSource;

  PrivateChatRepositoryImpl(this._dataSource);

  @override
  Future<Either<ErrorResponse, String>> create(
      {required String chatId,
      required String userId,
      required String opponentId,
      String? lastMessage}) async {
    try {
      return await _dataSource
          .create(
              chatId: chatId,
              dto: CreatePrivateChatDto(
                  opponent_id: opponentId,
                  user_id: userId,
                  last_message: lastMessage))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, String?>> getChatId(String opponentId) async {
    try {
      return await _dataSource.getChatId(opponentId).then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> delete(String chatId) async {
    try {
      return await _dataSource.delete(chatId).then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, List<PrivateChatEntity>>> fetch(
      {required String beforeAt, int take = 20}) async {
    try {
      return await _dataSource
          .fetch(beforeAt: beforeAt, take: take)
          .then((res) => res.map(PrivateChatEntity.from).toList())
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> update(
      {required String chatId, String? lastMessage, String? lastSeen}) async {
    try {
      return await _dataSource
          .update(chatId: chatId, lastMessage: lastMessage, lastSeen: lastSeen)
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }
}

@LazySingleton(as: PrivateMessageRepository)
class PrivateMessageRepositoryImpl
    with CustomLogger
    implements PrivateMessageRepository {
  final PrivateMessageDataSource _dataSource;

  PrivateMessageRepositoryImpl(this._dataSource);

  @override
  Future<Either<ErrorResponse, void>> create(
      {required String messageId,
      required String chatId,
      required String receiverId,
      required String content,
      ChatTypes type = ChatTypes.text}) async {
    try {
      return await _dataSource
          .create(
              messageId: messageId,
              dto: CreatePrivateMessageDto(
                  chat_id: chatId,
                  receiver_id: receiverId,
                  content: content,
                  type: type))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> delete(String messageId) async {
    try {
      return await _dataSource.delete(messageId).then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, List<PrivateMessageEntity>>> fetch(
      {required String beforeAt, required String chatId, int take = 20}) async {
    try {
      return await _dataSource
          .fetch(beforeAt: beforeAt, chatId: chatId, take: take)
          .then((res) => res.map(PrivateMessageEntity.from).toList())
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }
}
