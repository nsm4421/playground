part of 'repository_impl.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl with CustomLogger implements FeedRepository {
  final FeedDataSource _feedDataSource;
  final StorageDataSource _storageDataSource;

  FeedRepositoryImpl(
      {required FeedDataSource feedDataSource,
      required StorageDataSource storageDataSource})
      : _feedDataSource = feedDataSource,
        _storageDataSource = storageDataSource;

  @override
  Future<Either<ErrorResponse, void>> create(
      {required String id,
      required List<String> hashtags,
      required List<String> captions,
      required List<File> images}) async {
    try {
      return await _feedDataSource
          .create(
              id: id,
              dto: CreateFeedDto(
                  hashtags: hashtags,
                  captions: captions,
                  images: images.isEmpty
                      ? []
                      : await _storageDataSource
                          .uploadFeedImagesAndReturnPublicUrls(images)
                          .then((res) => res.toList())))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, List<FeedEntity>>> fetch(
      {required String beforeAt, int take = 20}) async {
    try {
      return await _feedDataSource
          .fetch(beforeAt: beforeAt, take: take)
          .then((res) => res.map(FeedEntity.from).toList())
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> edit(
      {required String id,
      String? content,
      List<String>? hashtags,
      List<String>? captions,
      List<File>? images}) async {
    try {
      return await _feedDataSource
          .edit(
              id: id,
              dto: UpdateFeedDto(
                  hashtags: hashtags,
                  captions: captions,
                  images: (images == null || images.isEmpty)
                      ? null
                      : await _storageDataSource
                          .uploadFeedImagesAndReturnPublicUrls(images)
                          .then((res) => res.toList())))
          .then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> delete(String id) async {
    try {
      return await _feedDataSource.delete(id).then(Right.new);
    } catch (error) {
      logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }
}
