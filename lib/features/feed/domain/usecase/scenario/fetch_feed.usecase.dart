part of "../feed.usecase_module.dart";

class FetchFeedsUseCase {
  final FeedRepository _repository;

  FetchFeedsUseCase(this._repository);

  Future<ResponseWrapper<void>> call(
      {required DateTime beforeAt,
      int take = 20,
      bool ascending = true}) async {
    return _repository.fetchFeeds(
        beforeAt: beforeAt, take: take, ascending: ascending);
  }
}
