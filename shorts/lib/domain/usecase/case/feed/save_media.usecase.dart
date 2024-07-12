part of '../../module/feed/feed.usecase.dart';

class SaveMediaUseCase {
  final FeedRepository _repository;

  SaveMediaUseCase(this._repository);

  Future<Either<Failure, String>> call(
          {required feedId,
          required MediaType type,
          required File file}) async =>
      await _repository.saveMedia(feedId: feedId, type: type, file: file);
}
