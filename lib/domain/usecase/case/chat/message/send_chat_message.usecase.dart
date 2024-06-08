part of '../../../module/chat/chat_message.usecase.dart';

class SendChatMessageUseCase {
  final ChatMessageRepository _repository;

  SendChatMessageUseCase(this._repository);

  Future<Either<Failure, void>> call(ChatMessageEntity entity) async =>
      await _repository.sendChatMessage(entity.copyWith(
          id: entity.id ?? const Uuid().v4(),
          createdAt: DateTime.now().toIso8601String()));
}
