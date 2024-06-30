part of 'package:my_app/domain/usecase/module/chat/open_chat.usecase.dart';

class GetOpenChatStreamUseCase {
  final OpenChatRepository _repository;

  GetOpenChatStreamUseCase(this._repository);

  Stream<List<OpenChatEntity>> call() {
    return _repository.chatStream;
  }
}
