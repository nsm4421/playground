part of "../feed.usecase_module.dart";

class CreateFeedCommentUseCase {
  final FeedCommentRepository _repository;

  CreateFeedCommentUseCase(this._repository);

  Future<ResponseWrapper<void>> call(FeedCommentEntity entity) async {
    return await _repository.createComment(entity);
  }
}
