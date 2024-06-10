part of '../../../module/chat/chat_message.usecase.dart';

class DeleteChatMessageUseCase {
  final ChatMessageRepository _repository;

  DeleteChatMessageUseCase(this._repository);

  Future<Either<Failure, void>> call(ChatMessageEntity entity) async =>
      await _repository.sendChatMessage(entity);
}
