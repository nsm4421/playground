part of "display_feed.bloc.dart";

final class DisplayFeedEvent extends FeedEvent {}

final class FeedCreatedEvent extends DisplayFeedEvent {
  final FeedEntity _feed;

  FeedCreatedEvent(this._feed);
}

final class FetchFeedEvent extends DisplayFeedEvent {
  final int take;

  FetchFeedEvent({this.take = 20});
}

final class LikeFeedEvent extends DisplayFeedEvent {
  final String feedId;

  LikeFeedEvent(this.feedId);
}

final class CancelLikeFeedEvent extends DisplayFeedEvent {
  final String feedId;
  final String emotionId;

  CancelLikeFeedEvent({required this.feedId, required this.emotionId});
}

final class DeleteFeedEvent extends DisplayFeedEvent {
  final String feedId;

  DeleteFeedEvent(this.feedId);
}
