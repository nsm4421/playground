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
