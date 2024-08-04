part of "../../../data/repository_impl/feed/feed.repository_impl.dart";

abstract interface class FeedRepository {
  Future<ResponseWrapper<List<FeedEntity>>> fetchFeeds(
      {required DateTime beforeAt, int take = 20});

  Future<ResponseWrapper<void>> createFeed(FeedEntity entity);

  Future<ResponseWrapper<void>> modifyFeed(
      {required String feedId,
      String? content,
      List<String>? media,
      List<String>? hashtags});

  Future<ResponseWrapper<void>> deleteFeedById(String feedId);

  Future<ResponseWrapper<Iterable<String>>> uploadMedia(
      {required String feedId, required Iterable<File> files});
}
