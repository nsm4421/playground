part of 'package:my_app/domain/usecase/module/chat/open_chat.usecase.dart';

class ModifyOpenChatUseCase {
  final OpenChatRepository _repository;

  ModifyOpenChatUseCase(this._repository);

  Future<Either<Failure, void>> call(String chatId,
      {String? title, DateTime? lastTalkAt, String? lastMessage}) async {
    return await _repository.modifyChat(chatId,
        title: title, lastTalkAt: lastTalkAt, lastMessage: lastMessage);
  }
}
