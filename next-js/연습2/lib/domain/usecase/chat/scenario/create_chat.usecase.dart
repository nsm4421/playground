part of "../chat.usecase_module.dart";

class CreateOpenChatUseCase {
  final OpenChatRepository _repository;

  CreateOpenChatUseCase(this._repository);

  Future<ResponseWrapper<void>> call(
      {required String title, required List<String> hashtags}) async {
    return await _repository.createChat(OpenChatEntity(
        title: title, hashtags: hashtags, lastMessage: 'chat room created'));
  }
}
