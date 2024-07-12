part of 'feed_comment.bloc.dart';

@immutable
sealed class FeedCommentState {
  const FeedCommentState();
}

final class InitialFeedCommentState extends FeedCommentState {}

final class FeedCommentLoadingState extends FeedCommentState {}

final class FeedCommentFailureState extends FeedCommentState {
  final String message;

  const FeedCommentFailureState(this.message);
}

final class FeedCommentSuccessState extends FeedCommentState {}
