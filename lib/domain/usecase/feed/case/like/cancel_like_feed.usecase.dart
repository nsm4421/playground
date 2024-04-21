import 'package:fpdart/fpdart.dart';
import 'package:hot_place/domain/repository/feed/like/like_feed.repository.dart';

import '../../../../../../core/error/failure.constant.dart';

class CancelLikeFeedUseCase {
  final LikeFeedRepository _repository;

  CancelLikeFeedUseCase(this._repository);

  Future<Either<Failure, void>> call(String likeId) async {
    return await _repository.cancelLikeById(likeId);
  }
}
