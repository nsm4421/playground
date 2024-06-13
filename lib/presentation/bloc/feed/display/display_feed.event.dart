part of "display_feed.bloc.dart";

@immutable
sealed class DisplayFeedEvent {}

final class InitDisplayFeedEvent extends DisplayFeedEvent {}

final class FetchDisplayFeedEvent extends DisplayFeedEvent {}

final class DeleteDisplayFeedEvent extends DisplayFeedEvent {
  final FeedEntity feed;

  DeleteDisplayFeedEvent(this.feed);
}

final class LikeOnFeedEvent extends DisplayFeedEvent {
  final FeedEntity feed;

  LikeOnFeedEvent(this.feed);
}

final class SendLikeOnFeedEvent extends LikeOnFeedEvent {
  SendLikeOnFeedEvent(super.feed);
}

final class DeleteLikeOnFeedEvent extends LikeOnFeedEvent {
  DeleteLikeOnFeedEvent(super.feed);
}
