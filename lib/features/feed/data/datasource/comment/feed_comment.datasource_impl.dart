import 'package:logger/logger.dart';
import 'package:portfolio/features/main/data/datasource/base.datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/comment/feed_comment.model.dart';
import '../../model/comment/feed_comment_for_rpc.model.dart';

part "feed_comment.datasource.dart";

class FeedCommentDataSourceImpl implements FeedCommentDataSource {
  final SupabaseClient _client;
  final Logger _logger;

  FeedCommentDataSourceImpl(
      {required SupabaseClient client, required Logger logger})
      : _client = client,
        _logger = logger;

  @override
  // TODO: implement tableName
  String get tableName => throw UnimplementedError();

  @override
  FeedCommentModel audit(FeedCommentModel model) {
    // TODO: implement audit
    throw UnimplementedError();
  }

  @override
  Future<void> createComment(FeedCommentModel model) {
    // TODO: implement createComment
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCommentById(String commentId) {
    // TODO: implement deleteCommentById
    throw UnimplementedError();
  }

  @override
  Future<Iterable<FeedCommentModelForRpc>> fetchComments(
      {required DateTime beforeAt,
      required String feedId,
      int take = 20,
      bool ascending = true}) {
    // TODO: implement fetchComments
    throw UnimplementedError();
  }
}
