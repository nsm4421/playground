part of '../usecase.dart';

class DeleteFeedCommentUseCase {
  final FeedRepository _repository;

  DeleteFeedCommentUseCase(this._repository);

  Future<ResponseWrapper<void>> call(String commentId) async {
    return await _repository.deleteCommentById(commentId).then(
        (res) => res.copyWith(message: res.ok ? '댓글 삭제하기 성공' : '댓글 삭제하기 실패'));
  }
}
