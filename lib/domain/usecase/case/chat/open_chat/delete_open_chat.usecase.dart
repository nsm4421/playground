part of 'package:my_app/domain/usecase/module/chat/open_chat.usecase.dart';

class DeleteOpenChatUseCase {
  final OpenChatRepository _repository;

  DeleteOpenChatUseCase(this._repository);

  Future<Either<Failure, void>> call(String chatId) async {
    return await _repository.deleteChatById(chatId);
  }
}
