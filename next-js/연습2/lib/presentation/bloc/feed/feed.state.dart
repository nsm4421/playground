part of "feed.bloc_module.dart";

@sealed
abstract class FeedState<T> {
  Status status; // 피드 or 댓글 status
  bool isFetching;
  Status emotionStatus; // 좋아요 status
  String? message;
  DateTime beforeAt;
  bool isEnd;
  List<T> data;

  FeedState(
      {this.status = Status.initial,
      this.emotionStatus = Status.initial,
      this.isFetching = false,
      this.message,
      required this.beforeAt,
      this.isEnd = false,
      this.data = const []});

  FeedState<T> copyWith(
      {Status? status,
      Status? emotionStatus,
      bool? isFetching,
      String? message,
      DateTime? beforeAt,
      bool? isEnd,
      List<T>? data});
}
