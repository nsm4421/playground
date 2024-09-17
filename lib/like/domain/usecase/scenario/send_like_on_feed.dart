part of '../usecase.dart';

class SendLikeOnFeedUseCase {
  final LikeRepository _repository;

  SendLikeOnFeedUseCase(this._repository);

  Future<UseCaseResponseWrapper<String>> call(String feedId) async {
    return await _repository
        .sendLike(referenceId: feedId, referenceTable: Tables.feeds)
        .then(UseCaseResponseWrapper<String>.from);
  }
}
