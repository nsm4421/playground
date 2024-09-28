part of '../usecase.dart';

class SendDmUseCase {
  final ChatRepository _repository;

  SendDmUseCase(this._repository);

  Future<ResponseWrapper<void>> call(
      {String? chatId,
      required String currentUid,
      required String opponentUid,
      ChatMessageType type = ChatMessageType.text,
      required String content}) async {
    log('[SendDmUseCase]DM 보내기');
    // 채팅방 id 조회
    String $chatId = chatId ?? '';
    if (chatId == null) {
      final chatIdRes =
          await _repository.findChatByUidOrElseCreate(opponentUid);
      if (!chatIdRes.ok) {
        return const ErrorResponse(message: '채팅방 조회과정에서 오류가 발행했습니다');
      }
      $chatId = chatIdRes.data!.id!;
    }
    // 채팅 메세지 생성
    return await _repository.createChatMessage(
        chatId: $chatId,
        type: type,
        content: content,
        opponentUid: opponentUid);
  }
}
