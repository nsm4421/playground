part of '../export.usecase.dart';

class FetchLatestPrivateChatMessagesUseCase {
  final PrivateChatRepository _repository;

  FetchLatestPrivateChatMessagesUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<List<PrivateChatMessageEntity>>>>
      call(String currentUid) async {
    return await _repository.fetchLatestMessages(currentUid);
  }
}

class FetchPrivateChatMessagesUseCase {
  final PrivateChatRepository _repository;

  FetchPrivateChatMessagesUseCase(this._repository);

  Future<
      Either<ErrorResponse,
          SuccessResponse<Pageable<PrivateChatMessageEntity>>>> call(
      {int? lastMessageId,
      required String opponentUid,
      required int page,
      int pageSize = 20}) async {
    return await _repository.fetchMessages(
        lastMessageId: lastMessageId,
        opponentUid: opponentUid,
        page: page,
        pageSize: pageSize);
  }
}
