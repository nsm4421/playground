part of 'display_feed.bloc.dart';

class DisplayFeedState {
  final Status status;
  final String errorMessage;
  final bool isEnd;
  late final DateTime beforeAt;
  late final List<FeedEntity> data;

  DisplayFeedState(
      {this.status = Status.initial,
      this.errorMessage = '',
      this.isEnd = false,
      DateTime? beforeAt,
      List<FeedEntity>? data}) {
    this.beforeAt = beforeAt ?? DateTime.now().toUtc();
    this.data = data ?? [];
  }

  DisplayFeedState copyWith({
    Status? status,
    String? errorMessage,
    bool? isEnd,
    DateTime? beforeAt,
    List<FeedEntity>? data,
  }) =>
      DisplayFeedState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        isEnd: isEnd ?? this.isEnd,
        beforeAt: beforeAt ?? this.beforeAt,
        data: data ?? this.data,
      );
}
