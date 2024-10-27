part of 'like.cubit.dart';

class LikeState {
  final Status status;
  final bool isLike;
  final int likeCount;
  final String errorMessage;

  LikeState(
      {this.status = Status.initial,
      this.isLike = false,
      this.likeCount = 0,
      this.errorMessage = ''});

  LikeState copyWith(
      {Status? status, bool? isLike, int? likeCount, String? errorMessage}) {
    return LikeState(
        status: status ?? this.status,
        isLike: isLike ?? this.isLike,
        likeCount: likeCount ?? this.likeCount,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
