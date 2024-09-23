part of 'datasource_impl.dart';

abstract class FeedDataSource {
  @Deprecated('RPC함수를 사용해 좋아요나 댓글 정보까지 같이 가져오도록 변경함')
  Future<Iterable<FetchFeedDto>> fetchFeeds(
      {required DateTime beforeAt, int limit = 20});

  Future<Iterable<FetchFeedByRpcDto>> fetchFeedsByRPC(
      {required DateTime beforeAt, int take = 20});

  Future<void> createFeed(CreateFeedDto dto);

  Future<void> editFeed(EditFeedDto dto);

  Future<void> deleteFeedById(String feedId);
}
