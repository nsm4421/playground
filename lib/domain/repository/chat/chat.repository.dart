part of '../export.repository.dart';

abstract interface class ChatRepository {
  Stream<MessageEntity> get messageStream;

  Either<ErrorResponse, SuccessResponse<void>> joinChat(String chatId);

  Either<ErrorResponse, SuccessResponse<void>> sendMessage(
      {required String chatId, required String message});

  Future<Either<ErrorResponse, SuccessResponse<void>>> create(
      {required String title, required List<String> hashtags});
}
