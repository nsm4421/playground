part of '../usecase.dart';

class GetChatByOpponentUidUseCase {
  final ChatRepository _repository;

  GetChatByOpponentUidUseCase(this._repository);

  Future<ResponseWrapper<ChatEntity>> call(String opponentUid) async {
    log('[GetChatByOpponentUidUseCase]채팅방 조회하기|opponent uid:$opponentUid');
    return await _repository.findChatByUidOrElseCreate(opponentUid).then(
        (res) => res.copyWith(
            message: res.ok ? '채팅방 가져오기 요청 성공' : '채팅방 가져오기 요청 실패'));
  }
}

class FindChatByIdUseCase {
  final ChatRepository _repository;

  FindChatByIdUseCase(this._repository);

  Future<ResponseWrapper<ChatEntity>> call(String chatId) async {
    log('[FindChatByIdUseCase]채팅방 조회하기|chat uid:$chatId');
    return await _repository.findChatById(chatId).then((res) =>
        res.copyWith(message: res.ok ? '채팅방 가져오기 요청 성공' : '채팅방 가져오기 요청 실패'));
  }
}

class FetchChatsUseCase {
  final ChatRepository _repository;

  FetchChatsUseCase(this._repository);

  Future<ResponseWrapper<List<ChatEntity>>> call(
      {required DateTime beforeAt, int take = 20}) async {
    log('[FetchChatsUseCase]채팅방 목록 가져오기');
    return await _repository.fetchChats(beforeAt: beforeAt, take: take).then(
        (res) => res.copyWith(
            message: res.ok ? '채팅방 목록 가져오기 요청 성공' : '채팅방 목록 가져오기 요청 실패'));
  }
}

class FetchChatMessagesUseCase {
  final ChatRepository _repository;

  FetchChatMessagesUseCase(this._repository);

  Future<ResponseWrapper<List<ChatMessageEntity>>> call(
      {required String chatId,
      required DateTime beforeAt,
      int take = 20}) async {
    log('[FetchChatMessagesUseCase]채팅 메세지 목록 가져오기 | 채팅방 id:$chatId');
    return await _repository
        .fetchChatMessages(chatId: chatId, beforeAt: beforeAt, take: take)
        .then((res) => res.copyWith(
            message: res.ok ? '채팅 메세지 목록 가져오기 요청 성공' : '채팅 메세지 목록 가져오기 요청 실패'));
  }
}
