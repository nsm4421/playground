part of '../../module/feed/feed.usecase.dart';

class DeleteFeedUseCase {
  final FeedRepository _repository;

  DeleteFeedUseCase(this._repository);

  Future<Either<Failure, void>> call(FeedEntity feed) async =>
      await _repository.deleteFeed(feed);
}
