import 'package:hot_place/domain/repository/feed/like/like_feed.repository.dart';
import 'package:hot_place/domain/usecase/feed/case/like/cancel_like_feed.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/like/get_like_feed_stream.usecase.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LikeFeedUseCase {
  final LikeFeedRepository _repository;

  LikeFeedUseCase(this._repository);

  @injectable
  CancelLikeFeedUseCase get cancelLike => CancelLikeFeedUseCase(_repository);

  @injectable
  GetLikeFeedStreamUseCase get getLikeFeedStream =>
      GetLikeFeedStreamUseCase(_repository);

  @injectable
  LikeFeedUseCase get likeFeed => LikeFeedUseCase(_repository);
}
