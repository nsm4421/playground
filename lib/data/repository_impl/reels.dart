part of 'repository_impl.dart';

@LazySingleton(as: ReelsRepository)
class ReelsRepositoryImpl with CustomLogger implements ReelsRepository {
  final ReelsDataSource _reelsDataSource;
  final StorageDataSource _storageDataSource;

  ReelsRepositoryImpl(
      {required ReelsDataSource reelsDataSource,
      required StorageDataSource storageDataSource})
      : _reelsDataSource = reelsDataSource,
        _storageDataSource = storageDataSource;

  @override
  Future<Either<ErrorResponse, void>> create(
      {required String id, String? caption, required File video}) async {
    try {
      return await _reelsDataSource
          .create(
              id: id,
              dto: CreateReelsDto(
                  caption: caption,
                  video: await _storageDataSource
                      .uploadReelsAndReturnPublicUrl(video)))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> delete(String id) async {
    try {
      return await _reelsDataSource.delete(id).then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> edit(
      {required String id, String? caption}) async {
    try {
      return await _reelsDataSource
          .edit(id: id, caption: caption)
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, List<ReelsEntity>>> fetch(
      {required String beforeAt, int take = 20}) async {
    try {
      return await _reelsDataSource
          .fetch(beforeAt: beforeAt, take: take)
          .then((res) => res.map(ReelsEntity.from).toList())
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }
}
