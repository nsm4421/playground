part of '../export.usecase.dart';

@lazySingleton
class ChatUseCase {
  final ChatRepository _repository;

  ChatUseCase(this._repository);

  String? get clientId => _repository.clientId;

  Stream<MessageEntity> get messageStream => _repository.messageStream;

  CreateChatUseCase get create => CreateChatUseCase(_repository);

  DeleteChatUseCase get delete => DeleteChatUseCase(_repository);

  JoinChatUseCase get joinChat => JoinChatUseCase(_repository);

  SendMessageUseCase get sendMessage => SendMessageUseCase(_repository);

  FetchGroupChatUseCase get fetchChats => FetchGroupChatUseCase(_repository);
}
