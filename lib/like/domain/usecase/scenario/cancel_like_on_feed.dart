part of '../usecase.dart';

class CancelLikeOnFeedUseCase {
  final LikeRepository _repository;

  CancelLikeOnFeedUseCase(this._repository);

  Future<UseCaseResponseWrapper<void>> call(String feedId) async {
    return await _repository
        .cancelLike(referenceId: feedId, referenceTable: Tables.feeds)
        .then(UseCaseResponseWrapper<void>.from);
  }
}
