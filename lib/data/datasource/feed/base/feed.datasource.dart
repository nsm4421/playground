part of 'feed.datasource_impl.dart';

abstract interface class FeedDataSource {}

abstract interface class LocalFeedDataSource implements FeedDataSource {}

abstract interface class RemoteFeedDataSource implements FeedDataSource {
  Stream<Iterable<FeedModel>> getFeedStream(
      {required String afterAt, bool descending = false});

  Future<Iterable<FeedModel>> fetchFeeds(
      {required String afterAt, int take = 20, bool descending = false});

  Future<void> saveFeed(FeedModel model);

  Future<void> uploadFile({required String path, required File file});

  Future<String> getDownloadUrl(String path);
}
