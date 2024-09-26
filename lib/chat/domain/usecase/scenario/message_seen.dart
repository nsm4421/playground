part of '../usecase.dart';

class SeeChatMessageUseCase {
  final ChatRepository _repository;

  SeeChatMessageUseCase(this._repository);

  Future<ResponseWrapper<void>> call(String messageId) async {
    log('[SeeChatMessageUseCase]채팅 메세지 확인|message id:$messageId');
    return await _repository.seeChatMessage(messageId).then((res) =>
        res.copyWith(
            message: res.ok ? 'is seen 업데이트 요청 성공' : 'is seen 업데이트 요청 실패'));
  }
}
