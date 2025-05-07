part of '../export.usecase.dart';

@lazySingleton
class GroupChatUseCase {
  final GroupChatRepository _repository;

  GroupChatUseCase(this._repository);

  String? get clientId => _repository.clientId;

  Stream<GroupChatMessageEntity> get messageStream => _repository.messageStream;

  InitGroupChatUseCase get init => InitGroupChatUseCase(_repository);

  CreateGroupChatUseCase get create => CreateGroupChatUseCase(_repository);

  DeleteGroupChatUseCase get delete => DeleteGroupChatUseCase(_repository);

  JoinGroupChatUseCase get join => JoinGroupChatUseCase(_repository);

  LeaveGroupChatUseCase get leave => LeaveGroupChatUseCase(_repository);

  SendGroupChatMessageUseCase get sendMessage =>
      SendGroupChatMessageUseCase(_repository);

  FetchGroupChatUseCase get fetchChats => FetchGroupChatUseCase(_repository);
}

@lazySingleton
class PrivateChatUseCase {
  final PrivateChatRepository _repository;

  PrivateChatUseCase(this._repository);

  String? get clientId => _repository.clientId;

  Stream<PrivateChatMessageEntity> get messageStream =>
      _repository.messageStream;

  SendPrivateChatMessageUseCase get sendMessage =>
      SendPrivateChatMessageUseCase(_repository);

  FetchLatestPrivateChatMessagesUseCase get fetchLatestMessages =>
      FetchLatestPrivateChatMessagesUseCase(_repository);

  FetchPrivateChatMessagesUseCase get fetchMessages =>
      FetchPrivateChatMessagesUseCase(_repository);
}
