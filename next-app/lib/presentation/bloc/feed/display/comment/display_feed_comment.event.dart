part of "display_feed_comment.bloc.dart";

final class DisplayFeedCommentEvent extends FeedEvent {}

final class FetchFeedCommentEvent extends DisplayFeedCommentEvent {
  final int take;

  FetchFeedCommentEvent({this.take = 20});
}

final class LikeFeedCommentEvent extends DisplayFeedCommentEvent {
  final String commentId;

  LikeFeedCommentEvent(this.commentId);
}

final class CancelLikeFeedCommentEvent extends DisplayFeedCommentEvent {
  final String emotionId;

  CancelLikeFeedCommentEvent(this.emotionId);
}
