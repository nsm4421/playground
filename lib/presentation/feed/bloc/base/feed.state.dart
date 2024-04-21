part of 'feed.bloc.dart';

@immutable
sealed class FeedState {
  const FeedState();
}

final class InitialFeedState extends FeedState {}

final class FeedLoadingState extends FeedState {}

final class FeedFailureState extends FeedState {
  final String message;

  const FeedFailureState(this.message);
}

final class UploadingFeedSuccessState extends FeedState {}

final class FetchingFeedSuccessState extends FeedState {
  final List<FeedEntity> feeds;

  const FetchingFeedSuccessState(this.feeds);
}
