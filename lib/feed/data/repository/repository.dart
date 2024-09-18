part of 'repository_impl.dart';

abstract class FeedRepository {
  /// 피드 기능
  Future<RepositoryResponseWrapper<List<FeedEntity>>> fetchFeeds(
      {required DateTime beforeAt, int take = 20});

  Future<RepositoryResponseWrapper<void>> createFeed(
      {required String feedId,
      required String media,
      required String caption,
      required List<String> hashtags});

  Future<RepositoryResponseWrapper<void>> editFeed(
      {required String feedId,
      String? media,
      String? caption,
      List<String>? hashtags});

  Future<RepositoryResponseWrapper<void>> deleteFeedById(String feedId);

  Future<RepositoryResponseWrapper<String>> uploadFeedImage(File feedImage,
      {bool upsert = false});

  /// 좋아요 기능
  Future<RepositoryResponseWrapper<String>> saveLike(String feedId);

  Future<RepositoryResponseWrapper<void>> deleteLike(String feedId);

  /// 댓글 기능
  Future<RepositoryResponseWrapper<List<ParentFeedCommentEntity>>>
      fetchParentComments(
          {required String feedId, required DateTime beforeAt, int take = 20});

  Future<RepositoryResponseWrapper<List<ChildFeedCommentEntity>>>
      fetchChildComments(
          {required String feedId,
          required String parentId,
          required DateTime beforeAt,
          int take = 20});

  Future<RepositoryResponseWrapper<void>> saveComment(
      {required String feedId, String? parentId, required String content});

  Future<RepositoryResponseWrapper<void>> deleteCommentById(String commentId);
}
