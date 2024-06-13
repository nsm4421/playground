part of 'feed.datasource_impl.dart';

abstract interface class FeedDataSource {}

abstract interface class LocalFeedDataSource implements FeedDataSource {}

abstract interface class RemoteFeedDataSource implements FeedDataSource {
  Future<Iterable<FeedWithAuthorModel>> fetchFeeds(
      {required DateTime beforeAt,
      bool ascending = false,
      int from = 0,
      int to = 20});

  Future<void> deleteFeed(String feedId);

  Future<void> saveFeed(FeedModel model);

  Future<String> uploadFile({required String feedId, required File file});

}
