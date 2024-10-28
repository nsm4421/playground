part of 'repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSource _feedDataSource;
  final StorageDataSource _storageDataSource;

  FeedRepositoryImpl({
    required FeedDataSource feedDataSource,
    required StorageDataSource storageDataSource,
  })  : _feedDataSource = feedDataSource,
        _storageDataSource = storageDataSource;

  @override
  Future<Either<ErrorResponse, List<FeedEntity>>> fetch(String beforeAt,
      {int take = 20}) async {
    try {
      return await _feedDataSource
          .fetch(beforeAt, take: take)
          .then((res) => res.map(FeedEntity.from).toList())
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> edit(
      {required String id,
      String? location,
      required String content,
      required List<String> hashtags,
      required List<File?> images,
      required List<String> captions,
      required bool isPrivate,
      bool update = false}) async {
    try {
      return await _feedDataSource
          .edit(EditFeedModel(
              id: id,
              location: location,
              content: content,
              hashtags: hashtags,
              images:
                  await _saveImagesAndReturnPublicUrls(id: id, images: images),
              captions: captions,
              is_private: isPrivate))
          .then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  @override
  Future<Either<ErrorResponse, void>> delete(String id) async {
    try {
      return await _feedDataSource.deleteById(id).then(Right.new);
    } on Exception catch (error) {
      customUtil.logger.e(error);
      return Left(ErrorResponse.from(error));
    }
  }

  Future<List<String>> _saveImagesAndReturnPublicUrls(
      {required String id, required List<File?> images}) async {
    return images.isEmpty
        ? []
        : await Future.wait(List.generate(images.length, (index) async {
            final image = images[index];
            return image == null
                ? ''
                : await _storageDataSource.uploadImageAndReturnPublicUrl(
                    file: image,
                    filename: '${id}_$index.jpg',
                    bucketName: Buckets.feeds.name);
          }));
  }
}
