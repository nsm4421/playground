part of "display_feed.bloc.dart";

final class DisplayFeedEvent extends FeedEvent {}

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
