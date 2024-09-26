import 'dart:developer';
import 'dart:io';

import 'package:flutter_app/feed/domain/entity/feed_comment.entity.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/shared.export.dart';
import '../../data/data.export.dart';
import '../entity/feed.entity.dart';

part 'scenario/fetch_feeds.dart';

part 'scenario/create_feed.dart';

part 'scenario/edit_feed.dart';

part 'scenario/delete_feed.dart';

part 'scenario/like_on_feed.dart';

part 'scenario/fetch_comment.dart';

part 'scenario/create_comment.dart';

part 'scenario/delete_feed_comment.dart';

@lazySingleton
class FeedUseCase {
  final FeedRepository _repository;

  FeedUseCase(this._repository);

  /// 피드
  FetchFeedsUseCase get fetchFeeds => FetchFeedsUseCase(_repository);

  CreateFeedUseCase get createFeed => CreateFeedUseCase(_repository);

  EditFeedUseCase get editFeed => EditFeedUseCase(_repository);

  DeleteFeedUseCase get deleteFeed => DeleteFeedUseCase(_repository);

  /// 좋아요
  SendLikeOnFeedUseCase get like => SendLikeOnFeedUseCase(_repository);

  CancelLikeOnFeedUseCase get cancelLike =>
      CancelLikeOnFeedUseCase(_repository);

  /// 댓글
  CreateFeedParentCommentUseCase get createParentComment =>
      CreateFeedParentCommentUseCase(_repository);

  CreateFeedChildCommentUseCase get createChildComment =>
      CreateFeedChildCommentUseCase(_repository);

  FetchParentFeedCommentUseCase get fetchParentComment =>
      FetchParentFeedCommentUseCase(_repository);

  FetchChildFeedCommentUseCase get fetchChildComment =>
      FetchChildFeedCommentUseCase(_repository);

  DeleteFeedCommentUseCase get deleteComment =>
      DeleteFeedCommentUseCase(_repository);
}
