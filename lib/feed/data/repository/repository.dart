part of 'repository_impl.dart';

abstract class FeedRepository {
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
}
