part of "../feed.usecase_module.dart";

class CreateFeedCommentUseCase {
  final FeedCommentRepository _repository;

  CreateFeedCommentUseCase(this._repository);

  Future<ResponseWrapper<void>> call({
    required String feedId,
    required String content,
  }) async {
    return await _repository
        .createComment(FeedCommentEntity(feedId: feedId, content: content));
  }
}
