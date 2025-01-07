part of '../export.usecase.dart';

@lazySingleton
class FeedUseCase {
  final FeedRepository _repository;

  FeedUseCase(this._repository);

  FetchFeedUseCase get fetchFeed => FetchFeedUseCase(_repository);

  CreateFeedUseCase get createFeed => CreateFeedUseCase(_repository);

  ModifyFeedUseCase get modifyFeed => ModifyFeedUseCase(_repository);

  DeleteFeedUseCase get deleteFeed => DeleteFeedUseCase(_repository);
}
