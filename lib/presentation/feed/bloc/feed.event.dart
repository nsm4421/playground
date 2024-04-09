part of 'feed.bloc.dart';

@immutable
sealed class FeedEvent {}

final class InitFeedStateEvent extends FeedEvent {}

final class UploadingFeedEvent extends FeedEvent {
  final UserEntity user;
  final String content;
  final List<String> hashtags;
  final List<File> images;

  UploadingFeedEvent({
    required this.user,
    required this.content,
    required this.hashtags,
    required this.images,
  });
}

final class FetchingFeedsEvent extends FeedEvent {
  final int page;
  final int size;

  FetchingFeedsEvent({required this.page, this.size = 20});
}
