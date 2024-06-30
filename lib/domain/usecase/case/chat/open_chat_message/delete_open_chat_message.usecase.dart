part of 'package:my_app/domain/usecase/module/chat/open_chat_message.usecase.dart';

class DeleteOpenChatMessageUseCase {
  final OpenChatMessageRepository _repository;

  DeleteOpenChatMessageUseCase(this._repository);

  Future<Either<Failure, void>> call(String messageId) async {
    return await _repository.deleteMessageById(messageId);
  }
}
