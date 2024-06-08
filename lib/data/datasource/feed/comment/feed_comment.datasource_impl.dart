import 'package:logger/logger.dart';
import 'package:my_app/domain/model/feed/comment/feed_comment.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'feed_comment.datasource.dart';

class LocalFeedCommentDataSourceImpl implements LocalFeedCommentDataSource {}

class RemoteFeedCommentDataSourceImpl implements RemoteFeedCommentDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  static const orderByField = "createdAt";

  RemoteFeedCommentDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  Future<Iterable<FeedCommentModel>> fetchComments(
          {required String afterAt,
          required String feedId,
          int take = 20,
          bool descending = false}) async =>
      throw UnimplementedError();

  @override
  Stream<Iterable<FeedCommentModel>> getCommentStream(
          {required String afterAt,
          required String feedId,
          bool descending = false}) =>
      throw UnimplementedError();

  @override
  Future<void> saveComment(FeedCommentModel model) async =>
      throw UnimplementedError();
}
