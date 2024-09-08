part of 'datasource_impl.dart';

abstract class FeedDataSource {
  Future<Iterable<FetchFeedDto>> fetchFeeds(
      {required DateTime beforeAt, int limit = 20});

  Future<void> createFeed(CreateFeedDto dto);

  Future<void> editFeed(EditFeedDto dto);

  Future<void> deleteFeedById(String feedId);
}
