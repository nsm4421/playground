part of "feed.bloc.dart";

@immutable
sealed class FeedEvent {}

final class InitFeedEvent extends FeedEvent {}

final class FetchFeedEvent extends FeedEvent {
  final int _take;

  FetchFeedEvent(this._take);
}

final class UploadFeedEvent extends FeedEvent {
  final String _text;
  final List<String> _hashtags;
  final List<File> _images;
  final File? _video;

  UploadFeedEvent(
      {required String text,
      required List<String> hashtags,
      required List<File> images,
      required File? video})
      : _text = text,
        _hashtags = hashtags,
        _images = images,
        _video = video;
}
