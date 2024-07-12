part of 'feed.bloc.dart';

@immutable
sealed class FeedEvent {}

final class InitFeedEvent extends FeedEvent {}

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

/// Search

final class SearchFeedsByHashtagEvent extends FeedEvent {
  final String hashtag;
  final int page;
  final int size;

  SearchFeedsByHashtagEvent(
      {required this.hashtag, this.page = 1, this.size = 20});
}

/// Like

final class LikeFeedEvent extends FeedEvent {
  final FeedEntity _feed;
  final UserEntity _currentUser;

  LikeFeedEvent({required FeedEntity feed, required UserEntity currentUser})
      : _feed = feed,
        _currentUser = currentUser;
}

final class CancelLikeFeedEvent extends FeedEvent {
  final FeedEntity _feed;
  final UserEntity _currentUser;

  CancelLikeFeedEvent(
      {required FeedEntity feed, required UserEntity currentUser})
      : _feed = feed,
        _currentUser = currentUser;
}
