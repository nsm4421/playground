part of "../impl/feed.remote_datasource_impl.dart";

abstract interface class FeedRemoteDataSource implements BaseRemoteDataSource<FeedModel> {
  Future<Iterable<FeedModelForRpc>> fetchFeeds(
      {required DateTime beforeAt, int take = 20});

  Future<FeedModel> createFeed(FeedModel model);

  Future<void> modifyFeed(
      {required String feedId,
      String? content,
      List<String>? media,
      List<String>? hashtags});

  Future<void> deleteFeedById(String feedId);

  Future<Iterable<String>> uploadMedia(
      {required String feedId, required Iterable<File> files});
}
