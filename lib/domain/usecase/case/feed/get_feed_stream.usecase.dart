part of '../../module/feed/feed.usecase.dart';

class GetFeedStreamUseCase {
  final FeedRepository _repository;

  GetFeedStreamUseCase(this._repository);

  Stream<List<FeedEntity>>? call(
      {required String afterAt, bool descending = false}) {
    return _repository
        .getFeedStream(afterAt: afterAt, descending: descending)
        .getRight()
        .toNullable();
  }
}
