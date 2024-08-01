part of "../feed.usecase_module.dart";

class DeleteFeedCommentUseCase {
  final FeedCommentRepository _repository;

  DeleteFeedCommentUseCase(this._repository);

  Future<ResponseWrapper<void>> call(String commentId) async {
    return await _repository.deleteCommentById(commentId);
  }
}
