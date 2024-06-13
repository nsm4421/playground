import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/repository_impl/like/like.repoistory_impl.dart';

part 'package:my_app/domain/usecase/case/like/send_like_on_feed.usecase.dart';

part 'package:my_app/domain/usecase/case/like/cancel_like_on_feed.usecase.dart';

part 'package:my_app/domain/usecase/case/like/get_like_on_feed_stream.usecase.dart';

@lazySingleton
class LikeUseCase {
  final LikeRepository _repository;

  LikeUseCase(this._repository);

  @injectable
  SendLikeOnFeedUseCase get sendLikeOnFeed =>
      SendLikeOnFeedUseCase(_repository);

  @injectable
  CancelLikeOnFeedUseCase get cancelLikeOnFeed =>
      CancelLikeOnFeedUseCase(_repository);

  @injectable
  GetLikeOnFeedStream get likeOnFeedStream => GetLikeOnFeedStream(_repository);
}
