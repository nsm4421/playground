part of 'display_feed.bloc.dart';

@sealed
final class DisplayFeedEvent {}

final class FetchFeedEvent extends DisplayFeedEvent {
  late final DateTime beforeAt;
  final int take;

  FetchFeedEvent({DateTime? beforeAt, this.take = 20}) {
    this.beforeAt = beforeAt ?? DateTime.now().toUtc();
  }
}

final class RefreshEvent extends DisplayFeedEvent {}

final class LikeOnFeedEvent extends DisplayFeedEvent {
  final String feedId;

  LikeOnFeedEvent(this.feedId);
}

final class CancelLikeOnFeedEvent extends DisplayFeedEvent {
  final String feedId;

  CancelLikeOnFeedEvent(this.feedId);
}
