import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/constant/media.dart';
import 'package:my_app/data/entity/feed/base/feed.entity.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/exception/failure.dart';
import '../../../../data/repository_impl/feed/feed.repository_impl.dart';

part '../../case/feed/fetch_feeds.usecase.dart';

part '../../case/feed/save_media.usecase.dart';

part '../../case/feed/save_feed.usecase.dart';

part '../../case/feed/delete_feed.usecase.dart';

@lazySingleton
class FeedUseCase {
  final FeedRepository _repository;

  FeedUseCase(this._repository);

  @injectable
  FetchFeedsUseCase get fetchFeeds => FetchFeedsUseCase(_repository);

  @injectable
  SaveFeedUseCase get saveFeed => SaveFeedUseCase(_repository);

  @injectable
  SaveMediaUseCase get saveMedia => SaveMediaUseCase(_repository);

  @injectable
  DeleteFeedUseCase get delete => DeleteFeedUseCase(_repository);
}
