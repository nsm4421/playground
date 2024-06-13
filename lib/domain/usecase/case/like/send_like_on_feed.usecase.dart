part of 'package:my_app/domain/usecase/module/like/like.usecase.dart';

class SendLikeOnFeedUseCase {
  final LikeRepository _repository;

  SendLikeOnFeedUseCase(this._repository);

  Future<Either<Failure, void>> call(String feedId) =>
      _repository.sendLikeOnFeed(feedId);
}
