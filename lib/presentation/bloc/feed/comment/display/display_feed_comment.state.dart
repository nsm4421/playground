part of '../feed_comment.bloc.dart';

@immutable
sealed class DisplayFeedCommentState {}

final class InitialDisplayFeedCommentState extends DisplayFeedCommentState {}

final class DisplayFeedCommentLoadingState extends DisplayFeedCommentState {}

final class DisplayFeedCommentSuccessState extends DisplayFeedCommentState {
  final List<FeedCommentEntity> comments;

  DisplayFeedCommentSuccessState(this.comments);
}

final class DisplayFeedCommentFailureState extends DisplayFeedCommentState {
  final String message;

  DisplayFeedCommentFailureState(this.message);
}
