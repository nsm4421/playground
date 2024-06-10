part of "display_feed_comment.bloc.dart";

@immutable
sealed class DisplayFeedCommentState {}

final class InitialDisplayFeedCommentState extends DisplayFeedCommentState {}

final class DisplayFeedCommentLoadingState extends DisplayFeedCommentState {}

final class DisplayFeedCommentSuccessState extends DisplayFeedCommentState {}

final class FeedCommentFetchedState extends DisplayFeedCommentSuccessState {
  final List<FeedCommentEntity> fetched;
  final bool isEnd;

  FeedCommentFetchedState({required this.fetched, required this.isEnd});
}

final class DisplayFeedCommentFailureState extends DisplayFeedCommentState {
  final String message;

  DisplayFeedCommentFailureState(this.message);
}
