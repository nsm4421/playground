import 'package:fpdart/fpdart.dart';
import 'package:hot_place/core/error/failure.constant.dart';

import '../../../../data/entity/feed/comment/feed_comment.entity.dart';

abstract interface class FeedCommentRepository {
  Either<Failure, Stream<List<FeedCommentEntity>>> getFeedCommentStream(
      String feedId,
      {bool ascending = false});

  Future<Either<Failure, void>> upsertFeedComment(FeedCommentEntity comment);

  Future<Either<Failure, void>> deleteFeedCommentById(String commentId);
}
