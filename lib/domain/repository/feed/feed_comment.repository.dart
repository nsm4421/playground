part of 'package:my_app/data/repository_impl/feed/feed_comment.repository_impl.dart';

abstract interface class FeedCommentRepository {
  Future<Either<Failure, List<FeedCommentEntity>>> fetchComments(
      {required DateTime beforeAt,
      required String feedId,
      required int from,
      required int to,
      bool ascending = false});

  Future<Either<Failure, void>> saveComment(FeedCommentEntity entity);

  Future<Either<Failure, void>> modifyComment(
      {required String commentId, required String content});

  Future<Either<Failure, void>> deleteComment(String commentId);
}
