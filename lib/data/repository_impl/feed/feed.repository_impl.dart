part of '../export.repository_impl.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl with LoggerUtil implements FeedRepository {
  final FeedRemoteDataSource _remoteDataSource;

  FeedRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> createFeed(
      {required List<File> files,
      required String content,
      required List<String> hashtags}) async {
    try {
      await _remoteDataSource.create(
          files: files,
          dto: CreateFeedDto(content: content, hashtags: hashtags));
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> deleteFeed(
      int id) async {
    try {
      await _remoteDataSource.delete(id);
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> modifyFeed(
      {required int id,
      required List<File> files,
      required String content,
      required List<String> hashtags}) async {
    try {
      await _remoteDataSource.modify(
          files: files,
          dto: ModifyFeedDto(id: id, content: content, hashtags: hashtags));
      return Right(SuccessResponse(payload: null));
    } catch (error) {
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }
}
