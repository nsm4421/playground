part of "display_feed.bloc.dart";

final class DisplayFeedState extends FeedState<FeedEntity> {
  DisplayFeedState({
    super.status,
    super.emotionStatus,
    super.isFetching,
    super.message,
    required super.beforeAt,
    super.isEnd,
    super.data = const [],
  });

  @override
  DisplayFeedState copyWith(
      {Status? status,
      Status? emotionStatus,
      bool? isFetching,
      String? message,
      DateTime? beforeAt,
      bool? isEnd,
      List<FeedEntity>? data}) {
    return DisplayFeedState(
        status: status ?? this.status,
        emotionStatus: emotionStatus ?? this.emotionStatus,
        isFetching: isFetching ?? this.isFetching,
        message: message ?? this.message,
        beforeAt: beforeAt ?? this.beforeAt,
        isEnd: isEnd ?? this.isEnd,
        data: data ?? this.data);
  }
}
