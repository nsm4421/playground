part of '../export.usecase.dart';

class JoinChatUseCase {
  final ChatRepository _repository;

  JoinChatUseCase(this._repository);

  Either<ErrorResponse, SuccessResponse<void>> call({required String chatId}) {
    // TODO : 채팅방 입장 가능여부 체크하기
    return _repository.joinChat(chatId);
  }
}
