import 'package:hot_place/domain/repository/feed/base/feed.repository.dart';
import 'package:hot_place/domain/usecase/feed/case/base/create_feed.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/base/delete_feed_by_id.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/base/get_feed_stream.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/base/get_feeds.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/base/modify_feed.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/base/upload_feed_images.usecase.dart';
import 'package:injectable/injectable.dart';

import '../../repository/feed/like/like_feed.repository.dart';
import 'case/like/cancel_like_feed.usecase.dart';
import 'case/like/get_like_feed_stream.usecase.dart';
import 'case/like/like_feed.usecase.dart';

@lazySingleton
class FeedUseCase {
  final FeedRepository _feedRepository;
  final LikeFeedRepository _likeFeedRepository;

  FeedUseCase({
    required FeedRepository feedRepository,
    required LikeFeedRepository likeFeedRepository,
  })  : _feedRepository = feedRepository,
        _likeFeedRepository = likeFeedRepository;

  @injectable
  CreateFeedUseCase get createFeed => CreateFeedUseCase(_feedRepository);

  @injectable
  DeleteFeedByIdUseCase get deleteFeed =>
      DeleteFeedByIdUseCase(_feedRepository);

  @injectable
  GetFeedStreamUseCase get feedStream => GetFeedStreamUseCase(_feedRepository);

  @injectable
  GetFeedsUseCase get getFeeds => GetFeedsUseCase(_feedRepository);

  @injectable
  ModifyFeedUseCase get modifyFeed => ModifyFeedUseCase(_feedRepository);

  @injectable
  UploadFeedImagesUseCase get uploadFeedImages =>
      UploadFeedImagesUseCase(_feedRepository);

  @injectable
  CancelLikeFeedUseCase get cancelLike =>
      CancelLikeFeedUseCase(_likeFeedRepository);

  @injectable
  GetLikeFeedStreamUseCase get likeStream =>
      GetLikeFeedStreamUseCase(_likeFeedRepository);

  @injectable
  LikeFeedUseCase get likeFeed => LikeFeedUseCase(_likeFeedRepository);
}
