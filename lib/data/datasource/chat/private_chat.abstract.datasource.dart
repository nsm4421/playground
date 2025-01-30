part of '../export.datasource.dart';

abstract class PrivateChatRemoteDataSource {
  /// id가 lastMessageId 보다 작은 레코드만 조회
  Future<Iterable<PrivateChatMessageDto>> fetchLatestMessages();

  /// id가 lastMessageId 보다 작은 레코드만 조회
  Future<Pageable<PrivateChatMessageDto>> fetchMessages({
    int? lastMessageId,
    required String opponentUid,
    required int page,
    int pageSize = 20,
  });
}
