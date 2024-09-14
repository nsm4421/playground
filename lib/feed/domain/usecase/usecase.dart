import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../shared/shared.export.dart';
import '../../data/data.export.dart';
import '../entity/feed.entity.dart';

part 'scenario/fetch_feeds.dart';

part 'scenario/create_feed.dart';

part 'scenario/edit_feed.dart';

part 'scenario/delete_feed.dart';

@lazySingleton
class FeedUseCase {
  final FeedRepository _repository;

  FeedUseCase(this._repository);

  FetchFeedsUseCase get fetchFeeds => FetchFeedsUseCase(_repository);

  CreateFeedUseCase get createFeed => CreateFeedUseCase(_repository);

  EditFeedUseCase get editFeed => EditFeedUseCase(_repository);

  DeleteFeedUseCase get deleteFeed => DeleteFeedUseCase(_repository);
}
