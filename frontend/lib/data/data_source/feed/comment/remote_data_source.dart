import 'package:hot_place/domain/model/feed/comment/feed_comment.model.dart';

abstract interface class RemoteFeedCommentDataSource {
  Stream<Iterable<FeedCommentModel>> getFeedCommentStream(String feedId,
      {bool ascending = false});

  Future<void> upsertFeedComment(FeedCommentModel comment);

  Future<void> deleteFeedCommentById(String commentId);
}
