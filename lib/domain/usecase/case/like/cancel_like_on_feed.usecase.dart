part of 'package:my_app/domain/usecase/module/like/like.usecase.dart';

class CancelLikeOnFeedUseCase {
  final LikeRepository _repository;

  CancelLikeOnFeedUseCase(this._repository);

  Future<Either<Failure, void>> call(String likeId) =>
      _repository.cancelLikeOnFeed(likeId);
}
