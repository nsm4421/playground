import 'package:hot_place/domain/model/feed/comment/feed_comment.model.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constant/supbase.constant.dart';
import '../../../../core/util/exeption.util.dart';
import 'remote_data_source.dart';

class RemoteFeedCommentDataSourceImpl implements RemoteFeedCommentDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  RemoteFeedCommentDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Stream<Iterable<FeedCommentModel>> getFeedCommentStream(String feedId,
      {bool ascending = false}) {
    try {
      return _client
          .from(TableName.feedComment.name)
          .stream(primaryKey: ['id'])
          .eq('feed_id', feedId)
          .order('created_at', ascending: ascending)
          .asyncMap((event) async => event.map(FeedCommentModel.fromJson));
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> upsertFeedComment(FeedCommentModel comment) async {
    try {
      await _client.rest
          .from(TableName.feedComment.name)
          .upsert(comment.toJson());
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }

  @override
  Future<void> deleteFeedCommentById(String commentId) async {
    try {
      await _client.rest
          .from(TableName.feedComment.name)
          .delete()
          .eq('id', commentId);
    } catch (err) {
      throw ExceptionUtil.toCustomException(err, logger: _logger);
    }
  }
}
