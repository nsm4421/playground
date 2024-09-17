import 'package:injectable/injectable.dart';

import '../../../shared/shared.export.dart';
import '../../data/repository/repository_impl.dart';

part './scenario/send_like_on_feed.dart';

part './scenario/cancel_like_on_feed.dart';

@lazySingleton
class LikeUseCase {
  final LikeRepository _repository;

  LikeUseCase(this._repository);

  SendLikeOnFeedUseCase get likeOnFeed => SendLikeOnFeedUseCase(_repository);

  CancelLikeOnFeedUseCase get cancelLikeOnFeed =>
      CancelLikeOnFeedUseCase(_repository);
}
