part of "../chat.usecase_module.dart";

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
