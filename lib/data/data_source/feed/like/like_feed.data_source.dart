import 'package:hot_place/domain/model/feed/like/like_feed.model.dart';

abstract interface class RemoteLikeFeedDataSource {
  Stream<LikeFeedModel?> getLikeStream(String feedId);

  Future<String> likeFeed(String feedId);

  Future<void> cancelLikeById(String likeId);
}
