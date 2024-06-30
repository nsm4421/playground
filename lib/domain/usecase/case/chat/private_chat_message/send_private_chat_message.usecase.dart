part of 'package:my_app/domain/usecase/module/chat/private_chat_message.usecase.dart';

class SendPrivateChatMessageUseCase {
  final PrivateChatMessageRepository _repository;

  SendPrivateChatMessageUseCase(this._repository);

  Future<Either<Failure, void>> call(PrivateChatMessageEntity entity) {
    String? chatId = entity.chatId;
    if (chatId == null) {
      final sender = entity.sender;
      final receiver = entity.receiver;
      if (sender?.id == null || receiver?.id == null) {
        throw ArgumentError('user id is not given');
      }
      final users = [sender!.id, receiver!.id];
      users.sort();
      chatId = users.join();
    }
    return _repository.saveChatMessage(entity.copyWith(
        id: entity.id ?? const Uuid().v4(),
        chatId: chatId,
        createdAt: entity.createdAt ?? DateTime.now()));
  }
}
