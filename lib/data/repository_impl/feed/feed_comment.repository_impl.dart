part of '../export.repository_impl.dart';

@LazySingleton(as: FeedCommentRepository)
class FeedCommentRepositoryImpl
    with LoggerUtil
    implements FeedCommentRepository {
  final FeedCommentRemoteDataSource _remoteDataSource;

  FeedCommentRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<ErrorResponse, SuccessResponse<CommentEntity>>> create(
      {required int feedId, required String content}) async {
    try {
      return await _remoteDataSource
          .create(feedId: feedId, content: content)
          .then(CommentEntity.from)
          .then((data) => SuccessResponse(payload: data))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<Pageable<CommentEntity>>>> fetch(
      {required int page, int pageSize = 20, required int feedId}) async {
    try {
      return await _remoteDataSource
          .fetch(page: page, pageSize: pageSize, feedId: feedId)
          .then((res) => res.convert<CommentEntity>(CommentEntity.from))
          .then((data) => SuccessResponse(payload: data))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<CommentEntity>>> modify(
      {required int commentId, required String content}) async {
    try {
      return await _remoteDataSource
          .modify(commentId: commentId, content: content)
          .then(CommentEntity.from)
          .then((data) => SuccessResponse(payload: data))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> delete(
      int commentId) async {
    try {
      return await _remoteDataSource
          .deleteById(commentId)
          .then((res) => SuccessResponse(payload: null))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }
}
