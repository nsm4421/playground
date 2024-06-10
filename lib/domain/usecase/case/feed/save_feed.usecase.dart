part of '../../module/feed/feed.usecase.dart';

class SaveFeedUseCase {
  final FeedRepository _repository;

  SaveFeedUseCase(this._repository);

  Future<Either<Failure, void>> call(FeedEntity entity) async {
    return await _repository.saveFeed(entity);
  }
}
