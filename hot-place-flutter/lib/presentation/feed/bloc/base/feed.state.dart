part of 'feed.bloc.dart';

@immutable
sealed class FeedState {
  const FeedState();
}

/// feed
final class InitialFeedState extends FeedState {}

final class FeedLoadingState extends FeedState {}

final class FeedFailureState extends FeedState {
  final String message;

  const FeedFailureState(this.message);
}

final class UploadingFeedSuccessState extends FeedState {}

/// Search
final class SearchFeedSuccessState extends FeedState {
  final String hashtag;
  final List<FeedEntity> feeds;

  const SearchFeedSuccessState({
    required this.hashtag,
    required this.feeds,
  });
}
