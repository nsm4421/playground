part of "../feed.usecase_module.dart";

class FetchFeedCommentsUseCase {
  final FeedCommentRepository _repository;

  FetchFeedCommentsUseCase(this._repository);

  Future<ResponseWrapper<List<FeedCommentEntity>>> call(
      {required String feedId,
      required DateTime beforeAt,
      int take = 20}) async {
    return _repository.fetchComments(
        feedId: feedId, beforeAt: beforeAt, take: take);
  }
}
