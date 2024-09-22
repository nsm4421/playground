part of 'feed_comment.bloc.dart';

class FeedCommentState {
  final String feedId;
  final bool isMounted;
  final Status status;
  final ParentFeedCommentEntity? parentComment;
  late final List<ParentFeedCommentEntity> comments;

  /// isEndMap : 조회할 댓글이 더 있는지 여부를 판단하기 위한 변수
  // key : 부모댓글은 feedId, 자식댓글은 부모댓글id
  late final Map<String, bool> isEndMap;
  final String errorMessage;

  FeedCommentState(
      {required this.feedId,
      this.isMounted = false,
      this.status = Status.initial,
      this.parentComment,
      List<ParentFeedCommentEntity>? comments,
      DateTime? beforeAt,
      Map<String, bool>? isEndMap,
      this.errorMessage = ''}) {
    this.comments = comments ?? [];
    this.isEndMap = isEndMap ?? {feedId: false};
  }

  FeedCommentState copyWith(
          {Status? status,
          bool? isMounted,
          ParentFeedCommentEntity? parentComment,
          List<ParentFeedCommentEntity>? comments,
          Map<String, bool>? isEndMap,
          String? errorMessage}) =>
      FeedCommentState(
          feedId: feedId,
          status: status ?? this.status,
          isMounted: isMounted ?? this.isMounted,
          parentComment: parentComment ?? this.parentComment,
          comments: comments ?? this.comments,
          isEndMap: isEndMap ?? this.isEndMap,
          errorMessage: errorMessage ?? this.errorMessage);
}
