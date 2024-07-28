part of "../chat.usecase_module.dart";

class SendPrivateChatMessageUseCase {
  final PrivateChatMessageRepository _repository;

  SendPrivateChatMessageUseCase(
      PrivateChatMessageRepository privateChatMessageRepository)
      : _repository = privateChatMessageRepository;

  Future<ResponseWrapper<void>> call(
      {required String receiver, required String content}) async {
    return await _repository.createChatMessage(
        content: content, receiver: receiver);
  }
}
