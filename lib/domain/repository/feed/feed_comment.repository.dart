part of 'package:my_app/data/repository_impl/feed/feed_comment.repository_impl.dart';

abstract interface class FeedCommentRepository {
  Either<Failure, Stream<List<FeedCommentEntity>>> getCommentStream(
      {required String afterAt,
      required String feedId,
      bool descending = false});

  Future<Either<Failure, List<FeedCommentEntity>>> fetchComments(
      {required String afterAt,
      required String feedId,
      int take = 20,
      bool descending = false});

  Future<Either<Failure, void>> saveComment(FeedCommentEntity entity);
}
