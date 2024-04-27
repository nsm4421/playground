import 'package:fpdart/fpdart.dart';
import 'package:hot_place/data/entity/feed/like/like_feed.entity.dart';

import '../../../../core/error/failure.constant.dart';

abstract class LikeFeedRepository {
  Stream<Iterable<LikeFeedEntity>> getLikeStream();

  Future<Either<Failure, void>> likeFeed(String feedId);

  Future<Either<Failure, void>> cancelLike(String feedId);
}
