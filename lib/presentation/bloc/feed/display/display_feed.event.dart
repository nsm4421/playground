part of "display_feed.bloc.dart";

@immutable
sealed class DisplayFeedEvent {}

final class InitDisplayFeedEvent extends DisplayFeedEvent {}

final class FetchDisplayFeedEvent extends DisplayFeedEvent {
  final int _take;

  FetchDisplayFeedEvent(this._take);
}
