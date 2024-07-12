part of 'package:my_app/data/repository_impl/feed/feed.repository_impl.dart';

abstract interface class FeedRepository {
  Future<Either<Failure, List<FeedEntity>>> fetchFeeds({
    required DateTime beforeAt,
    bool ascending = false,
    int from = 0,
    int to = 20,
  });

  Future<Either<Failure, void>> saveFeed(FeedEntity entity);

  Future<Either<Failure, void>> deleteFeed(FeedEntity feed);

  Future<Either<Failure, String>> saveMedia(
      {required feedId, required MediaType type, required File file});
}
