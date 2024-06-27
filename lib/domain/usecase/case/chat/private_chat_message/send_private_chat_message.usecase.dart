part of 'package:my_app/domain/usecase/module/chat/private_chat_message.usecase.dart';

class SendPrivateChatMessageUseCase {
  final PrivateChatMessageRepository _repository;

  SendPrivateChatMessageUseCase(this._repository);

  Future<Either<Failure, void>> call(PrivateChatMessageEntity entity) {
    return _repository.saveChatMessage(entity.copyWith(
        id: entity.id ?? const Uuid().v4(),
        createdAt: entity.createdAt ?? DateTime.now()));
  }
}
