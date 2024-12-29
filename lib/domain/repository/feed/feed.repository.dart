part of '../export.repository.dart';

abstract interface class FeedRepository {
  Future<Either<ErrorResponse, SuccessResponse<void>>> createFeed(
      {required List<File> files,
      required String content,
      required List<String> hashtags});

  Future<Either<ErrorResponse, SuccessResponse<void>>> modifyFeed(
      {required int id,
      required List<File> files,
      required String content,
      required List<String> hashtags});

  Future<Either<ErrorResponse, SuccessResponse<void>>> deleteFeed(int id);
}
