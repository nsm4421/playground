part of "display_feed_comment.bloc.dart";

final class DisplayFeedCommentState extends FeedState<FeedCommentEntity> {
  DisplayFeedCommentState({
    super.status,
    super.emotionStatus,
    super.isFetching,
    super.message,
    required super.beforeAt,
    super.isEnd,
    super.data = const [],
  });

  @override
  DisplayFeedCommentState copyWith({
    Status? status,
    Status? emotionStatus,
    bool? isFetching,
    String? message,
    DateTime? beforeAt,
    bool? isEnd,
    List<FeedCommentEntity>? data,
  }) {
    return DisplayFeedCommentState(
        status: status ?? this.status,
        emotionStatus: emotionStatus ?? this.emotionStatus,
        isFetching: isFetching ?? this.isFetching,
        message: message ?? this.message,
        beforeAt: beforeAt ?? this.beforeAt,
        isEnd: isEnd ?? this.isEnd,
        data: data ?? this.data);
  }
}
