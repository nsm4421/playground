part of "display_feed.bloc.dart";

@immutable
sealed class DisplayFeedState {}

final class InitialDisplayFeedState extends DisplayFeedState {}

final class DisplayFeedLoadingState extends DisplayFeedState {}

final class DisplayFeedSuccessState extends DisplayFeedState {
  final List<FeedEntity> feeds;

  DisplayFeedSuccessState(this.feeds);
}

final class DisplayFeedFailureState extends DisplayFeedState {
  final String message;

  DisplayFeedFailureState(this.message);
}
