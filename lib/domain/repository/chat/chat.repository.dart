part of '../export.repository.dart';

abstract interface class ChatRepository {
  String? get clientId;

  Stream<MessageEntity> get messageStream;

  Future<Either<ErrorResponse, SuccessResponse<Pageable<GroupChatEntity>>>>
      fetch({required int page, int pageSize = 20});

  Either<ErrorResponse, SuccessResponse<void>> joinChat(String chatId);

  Either<ErrorResponse, SuccessResponse<void>> sendMessage(
      {required String chatId,
      required String content,
      required String currentUid});

  Future<Either<ErrorResponse, SuccessResponse<void>>> create(
      {required String title, required List<String> hashtags});
}
