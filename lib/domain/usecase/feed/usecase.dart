part of '../export.usecase.dart';

@lazySingleton
class FeedUseCase {
  final FeedRepository _feedRepository;
  final ReactionRepository _reactionRepository;

  FeedUseCase(
      {required FeedRepository feedRepository,
      required ReactionRepository reactionRepository})
      : _feedRepository = feedRepository,
        _reactionRepository = reactionRepository;

  FetchFeedUseCase get fetchFeed => FetchFeedUseCase(_feedRepository);

  CreateFeedUseCase get createFeed => CreateFeedUseCase(_feedRepository);

  ModifyFeedUseCase get modifyFeed => ModifyFeedUseCase(_feedRepository);

  DeleteFeedUseCase get deleteFeed => DeleteFeedUseCase(_feedRepository);

  CountLikeOnFeedUseCase get countLike =>
      CountLikeOnFeedUseCase(_reactionRepository);

  LikeOnFeedUseCase get like => LikeOnFeedUseCase(_reactionRepository);

  CancelLikeOnFeedUseCase get cancelLike =>
      CancelLikeOnFeedUseCase(_reactionRepository);
}
