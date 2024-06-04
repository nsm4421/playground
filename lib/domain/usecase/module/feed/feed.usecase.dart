import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/feed/feed.entity.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/exception/failure.dart';
import '../../../../data/repository_impl/feed/feed.repository_impl.dart';

part '../../case/feed/get_feed_stream.usecase.dart';

part '../../case/feed/fetch_feeds.usecase.dart';

part '../../case/feed/upload_video.usecase.dart';

part '../../case/feed/upload_images.usecase.dart';

part '../../case/feed/save_feed.usecase.dart';

@lazySingleton
class FeedUseCase {
  final FeedRepository _repository;

  FeedUseCase(this._repository);

  GetFeedStreamUseCase get feedStream => GetFeedStreamUseCase(_repository);

  FetchFeedsUseCase get fetchFeeds => FetchFeedsUseCase(_repository);

  SaveFeedUseCase get saveFeed => SaveFeedUseCase(_repository);

  UploadVideoUseCase get uploadVideo => UploadVideoUseCase(_repository);

  UploadImagesUseCase get uploadImages => UploadImagesUseCase(_repository);
}
