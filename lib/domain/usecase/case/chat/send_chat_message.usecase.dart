part of '../../module/chat/chat.usecase.dart';

class SendChatMessageUseCase {
  final ChatRepository _repository;

  SendChatMessageUseCase(this._repository);

  Future<Either<Failure, void>> call(ChatMessageEntity entity) async =>
      await _repository.sendChatMessage(entity.copyWith(
          id: entity.id ?? const Uuid().v4(),
          createdAt: DateTime.now().toIso8601String()));
}
