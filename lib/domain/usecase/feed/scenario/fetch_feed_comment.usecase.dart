part of "../feed.usecase_module.dart";

class FetchFeedCommentsUseCase {
  final FeedCommentRepository _repository;

  FetchFeedCommentsUseCase(this._repository);

  Future<ResponseWrapper<void>> call(
      {required String feedId,
      required DateTime beforeAt,
      int take = 20,
      bool ascending = true}) async {
    return _repository.fetchComments(
        feedId: feedId, beforeAt: beforeAt, take: take, ascending: ascending);
  }
}
