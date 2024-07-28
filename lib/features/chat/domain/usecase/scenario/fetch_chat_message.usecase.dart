part of "../chat.usecase_module.dart";

/// DM 메세지 가져오기
class FetchPrivateChatMessageUseCase {
  final PrivateChatMessageRepository _repository;

  FetchPrivateChatMessageUseCase(this._repository);

  Future<ResponseWrapper<List<PrivateChatMessageEntity>>> call(
      {required String receiver,
      required DateTime beforeAt,
      int take = 20,
      bool ascending = true}) async {
    return await _repository.fetchMessages(
        receiver: receiver,
        beforeAt: beforeAt,
        take: take,
        ascending: ascending);
  }
}

/// 최신 DM 메세지 가져오기
class FetchLatestChatMessageUseCase {
  final PrivateChatMessageRepository _repository;

  FetchLatestChatMessageUseCase(this._repository);

  Future<ResponseWrapper<List<PrivateChatMessageEntity>>> call(
      DateTime afterAt) async {
    return await _repository.fetchLastMessages(afterAt);
  }
}

/// 오픈 채팅방 가져오기
class FetchOpenChatMessageUseCase {
  final OpenChatMessageRepository _repository;

  FetchOpenChatMessageUseCase(this._repository);

  Future<ResponseWrapper<List<OpenChatMessageEntity>>> call(
      {required String chatId,
      required int page,
      required DateTime beforeAt,
      int size = 20,
      bool ascending = true}) async {
    final from = (page - 1) * size;
    final to = page * size - 1;
    return await _repository.fetchMessages(
        chatId: chatId,
        beforeAt: beforeAt,
        from: from,
        to: to,
        ascending: ascending);
  }
}
