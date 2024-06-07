part of '../../module/chat/chat.usecase.dart';

class GetChatStreamUseCase {
  final ChatRepository _repository;

  GetChatStreamUseCase(this._repository);

  Stream<List<ChatEntity>> call() => _repository.getChatStream();
}
