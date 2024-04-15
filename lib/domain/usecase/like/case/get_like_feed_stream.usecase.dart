import 'package:hot_place/data/entity/feed/like/like_feed.entity.dart';
import 'package:hot_place/domain/repository/feed/like/like_feed.repository.dart';

class GetLikeFeedStreamUseCase {
  final LikeFeedRepository _repository;

  GetLikeFeedStreamUseCase(this._repository);

  Stream<LikeFeedEntity?> call(String feedId) =>
      _repository.getLikeStream(feedId);
}
