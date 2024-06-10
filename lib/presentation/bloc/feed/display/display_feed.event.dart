part of "display_feed.bloc.dart";

@immutable
sealed class DisplayFeedEvent {}

final class InitDisplayFeedEvent extends DisplayFeedEvent {}

final class FetchDisplayFeedEvent extends DisplayFeedEvent {}

final class DeleteDisplayFeedEvent extends DisplayFeedEvent {
  final FeedEntity feed;

  DeleteDisplayFeedEvent(this.feed);
}
