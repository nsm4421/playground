part of '../export.repository.dart';

abstract interface class FeedRepository {
  Future<Either<ErrorResponse, SuccessResponse<Pageable<FeedEntity>>>> fetch(
      {required int page, int pageSize = 20, int? lastId});

  Future<Either<ErrorResponse, SuccessResponse<void>>> create(
      {required List<File> files,
      required String content,
      required List<String> hashtags});

  Future<Either<ErrorResponse, SuccessResponse<void>>> modify(
      {required int id,
      required List<File> files,
      required String content,
      required List<String> hashtags});

  Future<Either<ErrorResponse, SuccessResponse<void>>> delete(int id);
}
