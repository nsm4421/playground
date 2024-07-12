part of "display_feed.bloc.dart";

@immutable
sealed class DisplayFeedState {}

final class InitialDisplayFeedState extends DisplayFeedState {}

final class DisplayFeedLoadingState extends DisplayFeedState {}

final class DisplayFeedSuccessState extends DisplayFeedState {}

final class FeedFetchedState extends DisplayFeedSuccessState {
  final List<FeedEntity> fetched;
  final bool isEnd;

  FeedFetchedState({required this.fetched, required this.isEnd});
}

final class DisplayFeedFailureState extends DisplayFeedState {
  final String message;

  DisplayFeedFailureState(this.message);
}
