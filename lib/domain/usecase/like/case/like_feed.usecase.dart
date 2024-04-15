import 'package:fpdart/fpdart.dart';
import 'package:hot_place/domain/repository/feed/like/like_feed.repository.dart';

import '../../../../core/error/failure.constant.dart';

class LikeFeedUseCase {
  final LikeFeedRepository _repository;

  LikeFeedUseCase(this._repository);

  Future<Either<Failure, void>> call(String feedId) async {
    return await _repository.likeFeed(feedId);
  }
}
