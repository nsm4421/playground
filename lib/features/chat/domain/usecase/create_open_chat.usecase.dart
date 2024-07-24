part of "chat.usecase_module.dart";

class CreateOpenChatUseCase {
  final OpenChatRepository _repository;

  CreateOpenChatUseCase(this._repository);

  Future<ResponseWrapper<void>> call({
    required String title,
    required List<String> hashtags,
    required String createdBy,
  }) async {
    return await _repository.createChat(OpenChatEntity(
        id: (const Uuid()).v4(),
        title: title,
        hashtags: hashtags,
        createdBy: createdBy,
        lastMessage: 'chat room created'));
  }
}
