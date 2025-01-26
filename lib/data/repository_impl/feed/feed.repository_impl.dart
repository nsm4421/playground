part of '../export.repository_impl.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl with LoggerUtil implements FeedRepository {
  final FeedRemoteDataSource _remoteDataSource;

  FeedRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<ErrorResponse, SuccessResponse<Pageable<FeedEntity>>>> fetch(
      {required int page, int pageSize = 20, int? lastId}) async {
    try {
      return await _remoteDataSource
          .fetch(page: page, pageSize: pageSize)
          .then((res) => res.convert<FeedEntity>(FeedEntity.from))
          .then((data) => SuccessResponse(payload: data))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> create(
      {required List<File> files,
      required String content,
      required List<String> hashtags}) async {
    try {
      return await _remoteDataSource
          .create(
              files: files,
              dto: CreateFeedDto(content: content, hashtags: hashtags))
          .then((res) => SuccessResponse(payload: null))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> delete(int id) async {
    try {
      return await _remoteDataSource
          .delete(id)
          .then((res) => SuccessResponse(payload: null))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }

  @override
  Future<Either<ErrorResponse, SuccessResponse<void>>> modify(
      {required int id,
      required List<File> files,
      required String content,
      required List<String> hashtags}) async {
    try {
      return await _remoteDataSource
          .modify(
              files: files,
              dto: ModifyFeedDto(id: id, content: content, hashtags: hashtags))
          .then((res) => SuccessResponse(payload: null))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error, logger: logger));
    }
  }
}
