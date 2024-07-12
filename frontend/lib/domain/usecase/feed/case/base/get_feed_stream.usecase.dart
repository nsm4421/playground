import '../../../../../data/entity/feed/base/feed.entity.dart';
import '../../../../repository/feed/base/feed.repository.dart';

class GetFeedStreamUseCase {
  final FeedRepository _repository;

  GetFeedStreamUseCase(this._repository);

  Stream<List<FeedEntity>> call() => _repository.feedStream;
}
