part of '../../module/feed/feed.usecase.dart';

class FetchFeedsUseCase {
  final FeedRepository _repository;

  FetchFeedsUseCase(this._repository);

  Future<Either<Failure, List<FeedEntity>>> call({
    required DateTime beforeAt,
    bool ascending = false,
    int from = 0,
    int to = 20,
  }) async =>
      await _repository.fetchFeeds(
          beforeAt: beforeAt, ascending: ascending, from: from, to: to);
}
