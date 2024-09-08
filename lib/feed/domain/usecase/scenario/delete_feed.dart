part of '../usecase.dart';

class DeleteFeedUseCase {
  final FeedRepository _repository;

  DeleteFeedUseCase(this._repository);

  Future<UseCaseResponseWrapper<void>> call(
    String feedId,
  ) async {
    return await _repository
        .deleteFeedById(feedId)
        .then(UseCaseResponseWrapper.from);
  }
}
