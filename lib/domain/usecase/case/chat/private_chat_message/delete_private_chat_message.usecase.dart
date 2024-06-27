part of 'package:my_app/domain/usecase/module/chat/private_chat_message.usecase.dart';

class DeletePrivateChatMessageUseCase {
  final PrivateChatMessageRepository _repository;

  DeletePrivateChatMessageUseCase(this._repository);

  Future<Either<Failure, void>> call(String messageId) {
    return _repository.deleteChatMessage(messageId);
  }
}
