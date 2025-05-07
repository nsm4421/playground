part of "../chat.usecase_module.dart";

class SendOpenChatMessageUseCase {
  final OpenChatRepository _openChatRepository;
  final OpenChatMessageRepository _openChatMessageRepository;

  SendOpenChatMessageUseCase(
      {required OpenChatRepository openChatRepository,
      required OpenChatMessageRepository openChatMessageRepository})
      : _openChatRepository = openChatRepository,
        _openChatMessageRepository = openChatMessageRepository;

  Future<ResponseWrapper<void>> call(
      {required String chatId, required String content}) async {
    final res = await _openChatMessageRepository
        .createChatMessage(OpenChatMessageEntity(chatId: chatId, content: content));
    if (res.ok) {
      await _openChatRepository.updateLastMessage(
          chatId: chatId, lastMessage: content);
      return ResponseWrapper.success(null);
    }
    return ResponseWrapper.error(res.message ?? 'send open chat message fails');
  }
}
