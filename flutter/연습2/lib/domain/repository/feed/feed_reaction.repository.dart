part of '../export.repository.dart';

abstract interface class FeedReactionRepository {
  Future<Either<ErrorResponse, SuccessResponse<int>>> count(int feedId);

  Future<Either<ErrorResponse, SuccessResponse<ReactionEntity>>> create(
      int feedId);

  Future<Either<ErrorResponse, SuccessResponse<void>>> delete(int feedId);
}
