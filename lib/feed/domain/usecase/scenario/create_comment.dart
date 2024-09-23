part of '../usecase.dart';

class CreateFeedParentCommentUseCase {
  final FeedRepository _repository;

  CreateFeedParentCommentUseCase(this._repository);

  Future<ResponseWrapper<void>> call({
    required String feedId,
    required String content,
  }) async {
    log('[CreateFeedParentCommentUseCase]댓글작성요청');
    try {
      return await _repository
          .saveParentComment(feedId: feedId, content: content)
          .then((res) =>
          res.copyWith(message: res.ok ? '피드 댓글 작성하기 성공' : '피드 댓글 작성하기 실패'));
    } catch (error){
      log(error.toString());
      throw Exception();
    }
  }
}

class CreateFeedChildCommentUseCase {
  final FeedRepository _repository;

  CreateFeedChildCommentUseCase(this._repository);

  Future<ResponseWrapper<void>> call({
    required String feedId,
    required String parentId,
    required String content,
  }) async {
    return await _repository
        .saveChildComment(feedId: feedId, parentId: parentId, content: content)
        .then((res) => res.copyWith(
            message: res.ok ? '피드 대댓글 작성하기 성공' : '피드 대댓글 작성하기 실패'));
  }
}
