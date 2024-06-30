import 'package:logger/logger.dart';
import 'package:my_app/core/constant/database.constant.dart';
import 'package:my_app/domain/model/feed/comment/fetch_feed_comment_response.dto.dart';
import 'package:my_app/domain/model/feed/comment/save_feed_comment_request.dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/exception/custom_exception.dart';

part '../abstract/feed_comment.remote_datasource.dart';

class RemoteFeedCommentDataSourceImpl implements RemoteFeedCommentDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  static const _orderByField = "createdAt";

  RemoteFeedCommentDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Future<Iterable<FetchFeedCommentResponseDto>> fetchComments(
      {required DateTime beforeAt,
      required String feedId,
      required int from,
      required int to,
      bool ascending = false}) async {
    try {
      return await _client.rest
          .from(TableName.feedComment.name)
          .select("*, author:${TableName.user.name}(*)")
          .lt(_orderByField, beforeAt.toIso8601String())
          .eq('feedId', feedId)
          .order(_orderByField, ascending: ascending)
          .range(from, to)
          .then((fetched) => fetched.map(FetchFeedCommentResponseDto.fromJson));
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> saveComment(SaveFeedCommentRequestDto dto) async {
    try {
      await _client.rest.from(TableName.feedComment.name).insert(dto.toJson());
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> modifyComment(
      {required String commentId, required String content}) async {
    try {
      await _client.rest
          .from(TableName.feedComment.name)
          .update({"content": content}).eq("id", commentId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  Future<void> deleteComment(String commentId) async {
    try {
      await _client.rest
          .from(TableName.feedComment.name)
          .delete()
          .eq("id", commentId);
    } catch (error) {
      throw CustomException.from(error, logger: _logger);
    }
  }

  @override
  RealtimeChannel getCommentChannel(
      {required String feedId,
      required PostgresChangeEvent changeEvent,
      required void Function(PostgresChangePayload p) callback}) {
    return _client
        .channel('${TableName.feedComment.name}:$feedId')
        .onPostgresChanges(
            event: changeEvent,
            schema: 'public',
            table: TableName.feedComment.name,
            filter: PostgresChangeFilter(
                type: PostgresChangeFilterType.eq,
                column: "feedId",
                value: feedId),
            callback: callback);
  }
}
