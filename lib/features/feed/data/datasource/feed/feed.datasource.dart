part of "feed.datasource_impl.dart";

abstract interface class FeedDataSource implements BaseDataSource {
  FeedModel audit(FeedModel model);

  Future<Iterable<FeedModelForRpc>> fetchFeeds(
      {required DateTime beforeAt, int take = 20, bool ascending = true});

  Future<void> createFeed(FeedModel model);

  Future<void> modifyFeed(FeedModel model);

  Future<void> deleteFeedById(String feedId);

  Future<Iterable<String>> uploadMedia(
      {required String feedId, required Iterable<File> files});
}
