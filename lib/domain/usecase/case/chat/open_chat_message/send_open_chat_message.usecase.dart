part of 'package:my_app/domain/usecase/module/chat/open_chat_message.usecase.dart';

class SendOpenChatMessageUseCase {
  final OpenChatMessageRepository _repository;

  SendOpenChatMessageUseCase(this._repository);

  Future<Either<Failure, void>> call(OpenChatMessageEntity entity) async {
    return await _repository.saveChatMessage(entity);
  }
}
