part of '../export.repository_impl.dart';

@LazySingleton(as: FeedReactionRepository)
class FeedReactionRepositoryImpl
    with LoggerUtil
    implements FeedReactionRepository {
  final FeedReactionRemoteDataSource _remoteDataSource;

  FeedReactionRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<ErrorResponse, SuccessResponse<int>>> count(int feedId) async {
    try {
      return await _remoteDataSource
          .count(feedId)
          .then((res) => SuccessResponse(payload: res))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<ReactionEntity>>> create(
      int feedId) async {
    try {
      return await _remoteDataSource
          .create(feedId)
          .then(ReactionEntity.from)
          .then((entity) => SuccessResponse(payload: entity))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> delete(
      int feedId) async {
    try {
      return await _remoteDataSource
          .delete(feedId)
          .then((_) => SuccessResponse(payload: null))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }
}
