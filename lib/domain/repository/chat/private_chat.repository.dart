part of '../export.repository.dart';

abstract interface class PrivateChatRepository {
  void init();

  String? get clientId;

  Future<Either<ErrorResponse, SuccessResponse<List<PrivateChatMessageEntity>>>>
      fetchLatestMessages(String currentUid);

  Future<
      Either<ErrorResponse,
          SuccessResponse<Pageable<PrivateChatMessageEntity>>>> fetchMessages({
    required int lastMessageId,
    required String opponentUid,
    required int page,
    int pageSize = 20,
  });

  Stream<PrivateChatMessageEntity> get messageStream;

  Either<ErrorResponse, SuccessResponse<void>> createMessage(
      {required String content, required String receiverId});

  Future<Either<ErrorResponse, SuccessResponse<void>>> deleteMessage(
      String messageId);
}
