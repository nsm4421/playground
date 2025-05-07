part of '../export.repository.dart';

abstract interface class GroupChatRepository
    with _GroupChatRepository, _GroupMessageRepository {
  void init();

  String? get clientId;
}

abstract mixin class _GroupChatRepository {
  Either<ErrorResponse, SuccessResponse<void>> joinChat(String chatId);

  Either<ErrorResponse, SuccessResponse<void>> leaveChat(String chatId);

  Future<Either<ErrorResponse, SuccessResponse<Pageable<GroupChatEntity>>>>
      fetchChats({required int page, int pageSize = 20});

  Future<Either<ErrorResponse, SuccessResponse<void>>> createChat(
      {required String title, required List<String> hashtags});

  Future<Either<ErrorResponse, SuccessResponse<void>>> deleteChat(
      String chatId);
}

abstract mixin class _GroupMessageRepository {
  Stream<GroupChatMessageEntity> get messageStream;

  Either<ErrorResponse, SuccessResponse<void>> createMessage(
      {required String chatId, required String content});
}
