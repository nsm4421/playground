part of '../../module/feed/feed.usecase.dart';

class UploadVideoUseCase {
  final FeedRepository _repository;

  UploadVideoUseCase(this._repository);

  Future<Either<Failure, String>> call(
          {required feedId, required File video}) async =>
      await _repository.saveVideo(feedId: feedId, video: video);
}
