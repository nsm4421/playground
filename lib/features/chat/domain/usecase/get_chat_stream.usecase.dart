part of "chat.usecase_module.dart";

class GetOpenChatStreamUseCase {
  final OpenChatRepository _repository;

  GetOpenChatStreamUseCase(this._repository);

  Stream<List<OpenChatEntity>> call() => _repository.chatStream;
}
