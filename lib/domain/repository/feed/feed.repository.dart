part of 'package:my_app/data/repository_impl/feed/feed.repository_impl.dart';

abstract interface class FeedRepository {
  Either<Failure, Stream<List<FeedEntity>>> getFeedStream(
      {required String afterAt, bool descending = false});

  Future<Either<Failure, List<FeedEntity>>> fetchFeeds(
      {required String afterAt, int take = 20, bool descending = false});

  Future<Either<Failure, void>> saveFeed(FeedEntity entity);

  Future<Either<Failure, List<String>>> saveImages(
      {required feedId, required List<File> images});

  Future<Either<Failure, String>> saveVideo(
      {required feedId, required File video});
}
