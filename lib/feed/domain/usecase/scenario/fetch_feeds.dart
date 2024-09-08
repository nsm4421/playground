part of '../usecase.dart';

class FetchFeedsUseCase {
  final FeedRepository _repository;

  FetchFeedsUseCase(this._repository);

  Future<UseCaseResponseWrapper<List<FeedEntity>>> call(
      {DateTime? beforeAt, int limit = 20}) async {
    return await _repository
        .fetchFeeds(
            beforeAt: (beforeAt ?? DateTime.now().toUtc()), limit: limit)
        .then(UseCaseResponseWrapper.from);
  }
}
