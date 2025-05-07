part of '../export.usecase.dart';

class SendGroupChatMessageUseCase {
  final GroupChatRepository _repository;

  SendGroupChatMessageUseCase(this._repository);

  Either<ErrorResponse, SuccessResponse<void>> call(
      {required String chatId, required String content}) {
    return _repository.createMessage(chatId: chatId, content: content);
  }
}

class SendPrivateChatMessageUseCase {
  final PrivateChatRepository _repository;

  SendPrivateChatMessageUseCase(this._repository);

  Either<ErrorResponse, SuccessResponse<void>> call(
      {required String receiverId, required String content}) {
    return _repository.createMessage(receiverId: receiverId, content: content);
  }
}
