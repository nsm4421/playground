part of '../export.repository.dart';

abstract interface class FeedCommentRepository {
  Future<Either<ErrorResponse, SuccessResponse<Pageable<CommentEntity>>>> fetch(
      {required int page, int pageSize = 20, required int feedId});

  Future<Either<ErrorResponse, SuccessResponse<CommentEntity>>> create(
      {required int feedId, required String content});

  Future<Either<ErrorResponse, SuccessResponse<CommentEntity>>> modify(
      {required int commentId, required String content});

  Future<Either<ErrorResponse, SuccessResponse<void>>> delete(int commentId);
}
