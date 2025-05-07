part of 'usecase.dart';

class GetChatUseCase with CustomLogger{
  final PrivateChatRepository _repository;

  GetChatUseCase(this._repository);

  Future<Either<ErrorResponse, String>> call({
    required String userId,
    required String opponentId,
  }) async {
    try {
      // 이미 채팅방이 존재하는 경우
      final fetched = await _repository.getChatId(opponentId).then((res) =>
          res.fold((l) => throw Exception('fetching chat fails'), (r) => r));
      if (fetched != null) return Right(fetched);
      // 채팅방을 신규로 생성하는 경우
      final chatId = const Uuid().v4();
      await _repository.create(
          chatId: chatId, userId: userId, opponentId: opponentId);
      await _repository.create(
          chatId: chatId, userId: opponentId, opponentId: userId);
      return Right(chatId);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }
}
