part of '../export.usecase.dart';

@lazySingleton
class FeedUseCase {
  final FeedRepository _feedRepository;
  final FeedReactionRepository _reactionRepository;
  final FeedCommentRepository _commentRepository;

  FeedUseCase(
      {required FeedRepository feedRepository,
      required FeedReactionRepository reactionRepository,
      required FeedCommentRepository commentRepository})
      : _feedRepository = feedRepository,
        _reactionRepository = reactionRepository,
        _commentRepository = commentRepository;

  /// feed
  FetchFeedUseCase get fetchFeed => FetchFeedUseCase(_feedRepository);

  CreateFeedUseCase get createFeed => CreateFeedUseCase(_feedRepository);

  ModifyFeedUseCase get modifyFeed => ModifyFeedUseCase(_feedRepository);

  DeleteFeedUseCase get deleteFeed => DeleteFeedUseCase(_feedRepository);

  /// like
  CountLikeOnFeedUseCase get countLike =>
      CountLikeOnFeedUseCase(_reactionRepository);

  LikeOnFeedUseCase get like => LikeOnFeedUseCase(_reactionRepository);

  CancelLikeOnFeedUseCase get cancelLike =>
      CancelLikeOnFeedUseCase(_reactionRepository);

  /// comment
  CreateFeedCommentUseCase get createComment =>
      CreateFeedCommentUseCase(_commentRepository);

  FetchFeedCommentUseCase get fetchComments =>
      FetchFeedCommentUseCase(_commentRepository);

  ModifyFeedCommentUseCase get modifyComment =>
      ModifyFeedCommentUseCase(_commentRepository);

  DeleteFeedCommentUseCase get deleteComment =>
      DeleteFeedCommentUseCase(_commentRepository);
}
