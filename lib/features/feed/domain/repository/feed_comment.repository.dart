part of 'package:portfolio/features/feed/data/repository_impl/feed_comment.repository_impl.dart';

abstract interface class FeedCommentRepository {
  Future<ResponseWrapper<List<FeedCommentEntity>>> fetchComments(
      {required DateTime beforeAt,
      required String feedId,
      int take = 20,
      bool ascending = true});

  Future<ResponseWrapper<void>> createComment(FeedCommentEntity model);

  Future<ResponseWrapper<void>> deleteCommentById(String commentId);
}
