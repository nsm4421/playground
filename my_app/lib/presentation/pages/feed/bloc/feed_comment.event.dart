abstract class FeedCommentEvent {
  const FeedCommentEvent();
}

class FeedCommentInitializedEvent extends FeedCommentEvent {
  final String feedId;

  FeedCommentInitializedEvent(this.feedId);
}
