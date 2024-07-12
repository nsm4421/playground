import 'package:hot_place/domain/model/feed/like/like_feed.model.dart';

abstract interface class RemoteLikeFeedDataSource {
  Stream<Iterable<LikeFeedModel>> getLikeStream();

  Future<void> likeFeed(String feedId);

  Future<void> cancelLike(String feedId);
}
