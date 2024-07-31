part of 'package:portfolio/features/feed/data/repository_impl/feed.repository_impl.dart';

abstract interface class FeedRepository {
  Future<ResponseWrapper<List<FeedEntity>>> fetchFeeds(
      {required DateTime beforeAt, int take = 20, bool ascending = true});

  Future<ResponseWrapper<void>> createFeed(FeedEntity entity);

  Future<ResponseWrapper<void>> modifyFeed(FeedEntity entity);

  Future<ResponseWrapper<void>> deleteFeedById(String feedId);
}
