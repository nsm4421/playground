part of '../export.repository.dart';

abstract interface class ReactionRepository {
  Future<Either<ErrorResponse, SuccessResponse<int>>> count(
      {required int id, required ReactionReference ref});

  Future<Either<ErrorResponse, SuccessResponse<ReactionEntity>>> create(
      {required int id, required ReactionReference ref});

  Future<Either<ErrorResponse, SuccessResponse<void>>> delete(
      {required int id, required ReactionReference ref});
}
