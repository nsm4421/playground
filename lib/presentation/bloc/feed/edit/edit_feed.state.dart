part of 'edit_feed.bloc.dart';

class EditFeedState {
  final Status status;
  final bool update;
  final bool isPrivate;
  final String content;
  final String location;
  late final List<FeedAsset> assets;
  late final List<String> hashtags;
  final String errorMessage;

  EditFeedState(
      {this.status = Status.initial,
      this.update = false, // true->modify, false->create
      this.isPrivate = true,
      this.location = '',
      this.content = '',
      List<FeedAsset>? assets,
      List<String>? hashtags,
      this.errorMessage = ''}) {
    this.assets = assets ?? [];
    this.hashtags = hashtags ?? [];
  }

  EditFeedState copyWith({
    Status? status,
    bool? isPrivate,
    String? content,
    String? location,
    List<FeedAsset>? assets,
    List<String>? hashtags,
    int? currentIndex,
    String? errorMessage,
  }) {
    return EditFeedState(
        status: status ?? this.status,
        isPrivate: isPrivate ?? this.isPrivate,
        content: content ?? this.content,
        location: location ?? this.location,
        assets: assets ?? this.assets,
        hashtags: hashtags ?? this.hashtags,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}

class FeedAsset {
  final File image;
  final String caption;

  FeedAsset({required this.image, required this.caption});

  FeedAsset copyWith({File? image, String? caption}) {
    return FeedAsset(
        image: image ?? this.image, caption: caption ?? this.caption);
  }
}
