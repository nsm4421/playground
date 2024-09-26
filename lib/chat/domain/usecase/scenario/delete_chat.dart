part of '../usecase.dart';

class DeleteChatUseCase {
  final ChatRepository _repository;

  DeleteChatUseCase(this._repository);

  Future<ResponseWrapper<void>> call(String chatId) async {
    log('[DeleteChatUseCase]채팅방 삭제 요청');
    return await _repository.deleteChat(chatId).then((res) =>
        res.copyWith(message: res.ok ? '채팅방 삭제 요청 성공' : '채팅방 삭제 요청 실패'));
  }
}

class DeleteChatMessageUseCase {
  final ChatRepository _repository;

  DeleteChatMessageUseCase(this._repository);

  Future<ResponseWrapper<void>> call(String messageId) async {
    log('[DeleteChatUseCase]채팅방 삭제 요청');
    return await _repository.deleteChat(messageId).then((res) =>
        res.copyWith(message: res.ok ? '채팅 메시제 삭제 요청 성공' : '채팅 메시제 삭제 요청 실패'));
  }
}
