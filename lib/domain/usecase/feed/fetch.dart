part of 'usecase.dart';

class FetchFeedUseCase {
  final FeedRepository _repository;

  FetchFeedUseCase(this._repository);

  Future<Either<ErrorResponse, List<FeedEntity>>> call(
      {required DateTime beforeAt, int take = 20}) async {
    return await _repository.fetch(
        beforeAt: beforeAt.toUtc().toIso8601String(), take: take);
  }
}

class SearchFeedUseCase {
  final FeedRepository _repository;

  SearchFeedUseCase(this._repository);

  Future<Either<ErrorResponse, List<FeedEntity>>> call(
      {required DateTime beforeAt,
      FeedSearchFields? searchField,
      String? searchText,
      int take = 20}) async {
    return await _repository.fetch(
        beforeAt: beforeAt.toUtc().toIso8601String(),
        searchField: searchField?.name,
        searchText: searchText,
        take: take);
  }
}
