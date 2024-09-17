part of 'display_feed.bloc.dart';

@sealed
final class DisplayFeedEvent {}

final class FetchFeedEvent extends DisplayFeedEvent {
  late final DateTime beforeAt;
  final int limit;

  FetchFeedEvent({DateTime? beforeAt, this.limit = 20}) {
    this.beforeAt = beforeAt ?? DateTime.now().toUtc();
  }
}

final class RefreshEvent extends DisplayFeedEvent {}
