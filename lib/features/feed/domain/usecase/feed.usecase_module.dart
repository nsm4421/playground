import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:portfolio/features/feed/domain/entity/feed/feed.entity.dart';

import '../../../main/core/constant/response_wrapper.dart';
import '../../data/repository_impl/feed.repository_impl.dart';
import '../../data/repository_impl/feed_comment.repository_impl.dart';
import '../entity/comment/feed_comment.entity.dart';

part "scenario/fetch_feed.usecase.dart";

part "scenario/create_feed.usecase.dart";

part "scenario/modify_feed.usecase.dart";

part "scenario/delete_feed.usecase.dart";

part "scenario/fetch_feed_comment.usecase.dart";

part "scenario/create_feed_comment.usecase.dart";

part "scenario/delete_feed_comment.usecase.dart";

@lazySingleton
class FeedUseCase {
  final FeedRepository _feedRepository;
  final FeedCommentRepository _commentRepository;

  FeedUseCase(
      {required FeedRepository feedRepository,
      required FeedCommentRepository commentRepository})
      : _feedRepository = feedRepository,
        _commentRepository = commentRepository;

  FetchFeedsUseCase get fetchFeeds => FetchFeedsUseCase(_feedRepository);

  CreateFeedUseCase get createFeed => CreateFeedUseCase(_feedRepository);

  ModifyFeedUseCase get modifyFeed => ModifyFeedUseCase(_feedRepository);

  DeleteFeedUseCase get deleteFeed => DeleteFeedUseCase(_feedRepository);

  FetchFeedCommentsUseCase get fetchComments =>
      FetchFeedCommentsUseCase(_commentRepository);

  CreateFeedCommentUseCase get createComment =>
      CreateFeedCommentUseCase(_commentRepository);

  DeleteFeedCommentUseCase get deleteComment =>
      DeleteFeedCommentUseCase(_commentRepository);
}
