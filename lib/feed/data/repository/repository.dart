part of 'repository_impl.dart';

abstract class FeedRepository {
  /// 피드 기능
  Future<ResponseWrapper<List<FeedEntity>>> fetchFeeds(
      {required DateTime beforeAt, int take = 20});

  Future<ResponseWrapper<void>> createFeed(
      {required String feedId,
      required String media,
      required String caption,
      required List<String> hashtags});

  Future<ResponseWrapper<void>> editFeed(
      {required String feedId,
      String? media,
      String? caption,
      List<String>? hashtags});

  Future<ResponseWrapper<void>> deleteFeedById(String feedId);

  Future<ResponseWrapper<String>> uploadFeedImage(File feedImage,
      {bool upsert = false});

  /// 좋아요 기능
  Future<ResponseWrapper<String>> saveLike(String feedId);

  Future<ResponseWrapper<void>> deleteLike(String feedId);

  /// 댓글 기능
  Future<ResponseWrapper<List<ParentFeedCommentEntity>>>
      fetchParentComments(
          {required String feedId, required DateTime beforeAt, int take = 20});

  Future<ResponseWrapper<List<ChildFeedCommentEntity>>>
      fetchChildComments(
          {required String feedId,
          required String parentId,
          required DateTime beforeAt,
          int take = 20});

  Future<ResponseWrapper<void>> saveParentComment(
      {required String feedId, required String content});

  Future<ResponseWrapper<void>> saveChildComment(
      {required String feedId,
      required String? parentId,
      required String content});

  Future<ResponseWrapper<void>> deleteCommentById(String commentId);
}
