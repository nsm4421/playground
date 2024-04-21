import 'package:hot_place/domain/repository/feed/base/feed.repository.dart';
import 'package:hot_place/domain/usecase/feed/case/base/create_feed.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/base/delete_feed_by_id.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/base/get_feed_stream.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/base/get_feeds.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/base/modify_feed.usecase.dart';
import 'package:hot_place/domain/usecase/feed/case/base/upload_feed_images.usecase.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FeedUseCase {
  final FeedRepository _repository;

  FeedUseCase(this._repository);

  @injectable
  CreateFeedUseCase get createFeed => CreateFeedUseCase(_repository);

  @injectable
  DeleteFeedByIdUseCase get deleteFeed => DeleteFeedByIdUseCase(_repository);

  @injectable
  GetFeedStreamUseCase get feedStream => GetFeedStreamUseCase(_repository);

  @injectable
  GetFeedsUseCase get getFeeds => GetFeedsUseCase(_repository);

  @injectable
  ModifyFeedUseCase get modifyFeed => ModifyFeedUseCase(_repository);

  @injectable
  UploadFeedImagesUseCase get uploadFeedImages =>
      UploadFeedImagesUseCase(_repository);
}
