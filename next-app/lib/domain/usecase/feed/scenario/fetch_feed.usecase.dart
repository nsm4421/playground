part of "../feed.usecase_module.dart";

class FetchFeedsUseCase {
  final FeedRepository _repository;

  FetchFeedsUseCase(this._repository);

  Future<ResponseWrapper<List<FeedEntity>>> call(
      {required DateTime beforeAt, int take = 20}) async {
    return _repository.fetchFeeds(beforeAt: beforeAt, take: take);
  }
}
