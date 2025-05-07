part of '../export.usecase.dart';

class FetchFeedCommentUseCase {
  final FeedCommentRepository _repository;

  FetchFeedCommentUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<Pageable<CommentEntity>>>> call(
      {required int page, int pageSize = 20, required int feedId}) async {
    return await _repository.fetch(
        page: page, pageSize: pageSize, feedId: feedId);
  }
}

class CreateFeedCommentUseCase {
  final FeedCommentRepository _repository;

  CreateFeedCommentUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<CommentEntity>>> call(
      {required String content, required int feedId}) async {
    return await _repository.create(content: content, feedId: feedId);
  }
}

class ModifyFeedCommentUseCase {
  final FeedCommentRepository _repository;

  ModifyFeedCommentUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<CommentEntity>>> call(
      {required String content, required int commentId}) async {
    return await _repository.modify(content: content, commentId: commentId);
  }
}

class DeleteFeedCommentUseCase {
  final FeedCommentRepository _repository;

  DeleteFeedCommentUseCase(this._repository);

  Future<Either<ErrorResponse, SuccessResponse<void>>> call(int feedId) async {
    return await _repository.delete(feedId);
  }
}
