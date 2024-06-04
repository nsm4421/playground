part of '../../module/feed/feed.usecase.dart';

class FetchFeedsUseCase {
  final FeedRepository _repository;

  FetchFeedsUseCase(this._repository);

  Future<Either<Failure, List<FeedEntity>>> call(
          {required String afterAt, int take = 20, bool descending = false}) =>
      _repository.fetchFeeds(
          afterAt: afterAt, take: take, descending: descending);
}
