part of "feed.bloc.dart";

@immutable
sealed class FeedState {}

/// 1. Initial
final class InitialFeedState extends FeedState {}

/// 2. Loading
final class FeedLoadingState extends FeedState {}

/// 3. Success
final class FeedSuccessState extends FeedState {}

/// 3-1. Fetch Feed Success
final class FetchFeedSuccessState extends FeedSuccessState {
  final List<FeedEntity> feeds;

  FetchFeedSuccessState(this.feeds);
}

/// 3-2. Upload Feed Success
final class UploadFeedSuccessState extends FeedSuccessState {}

/// 4. Error
final class FeedFailureState extends FeedState {
  final String message;

  FeedFailureState(this.message);
}
