part of '../export.usecase.dart';

@lazySingleton
class ChatUseCase {
  final ChatRepository _repository;

  ChatUseCase(this._repository);

  Stream<MessageEntity> get messageStream => _repository.messageStream;

  CreateChatUseCase get create => CreateChatUseCase(_repository);

  JoinChatUseCase get joinChat => JoinChatUseCase(_repository);

  SendMessageUseCase get sendMessage => SendMessageUseCase(_repository);
}
