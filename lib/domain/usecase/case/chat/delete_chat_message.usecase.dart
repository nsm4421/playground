part of '../../module/chat/chat.usecase.dart';

class DeleteChatMessageUseCase {
  final ChatRepository _repository;

  DeleteChatMessageUseCase(this._repository);

  Future<Either<Failure, void>> call(ChatMessageEntity entity) async =>
      await _repository.sendChatMessage(entity);
}
