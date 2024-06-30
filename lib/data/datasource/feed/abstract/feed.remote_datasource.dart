part of '../impl/feed.remote_datasource_impl.dart';

abstract interface class RemoteFeedDataSource {
  Future<Iterable<FetchFeedResponseDto>> fetchFeeds(
      {required DateTime beforeAt,
      bool ascending = false,
      int from = 0,
      int to = 20});

  Future<void> deleteFeed(String feedId);

  Future<void> saveFeed(SaveFeedRequestDto model);

  Future<String> uploadFile({required String feedId, required File file});
}
