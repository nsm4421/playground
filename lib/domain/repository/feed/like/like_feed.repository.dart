import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/feed/like/like_feed.entity.dart';

import '../../../../core/error/failure.constant.dart';

abstract class LikeFeedRepository {
  Stream<LikeFeedEntity?> getLikeStream(String feedId);

  Future<Either<Failure, String>> likeFeed(String feedId);

  Future<Either<Failure, void>> cancelLikeById(String likeId);
}
