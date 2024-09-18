part of '../usecase.dart';

class SendLikeOnFeedUseCase {
  final FeedRepository _repository;

  SendLikeOnFeedUseCase(this._repository);

  Future<UseCaseResponseWrapper<String>> call(String feedId) async {
    return await _repository
        .saveLike(feedId)
        .then(UseCaseResponseWrapper<String>.from);
  }
}

class CancelLikeOnFeedUseCase {
  final FeedRepository _repository;

  CancelLikeOnFeedUseCase(this._repository);

  Future<UseCaseResponseWrapper<void>> call(String feedId) async {
    return await _repository
        .deleteLike(feedId)
        .then(UseCaseResponseWrapper<void>.from);
  }
}
