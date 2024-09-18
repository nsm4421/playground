part of 'display_feed.bloc.dart';

class DisplayFeedState {
  final Status status;
  final String errorMessage;
  final bool isEnd;
  late final List<FeedEntity> data;

  DisplayFeedState(
      {this.status = Status.initial,
      this.errorMessage = '',
      this.isEnd = false,
      List<FeedEntity>? data}) {
    this.data = data ?? [];
  }

  DisplayFeedState copyWith({
    Status? status,
    String? errorMessage,
    bool? isEnd,
    List<FeedEntity>? data,
  }) =>
      DisplayFeedState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        isEnd: isEnd ?? this.isEnd,
        data: data ?? this.data,
      );
}
