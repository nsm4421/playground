part of '../../module/feed/feed.usecase.dart';

class UploadImagesUseCase {
  final FeedRepository _repository;

  UploadImagesUseCase(this._repository);

  Future<Either<Failure, List<String>>> call(
          {required feedId, required List<File> images}) async =>
      await _repository.saveImages(feedId: feedId, images: images);
}
