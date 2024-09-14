part of 'create_feed.bloc.dart';

class CreateFeedState extends BaseState {
  late final String caption;
  late final List<String> hashtags;

  CreateFeedState({
    super.id,
    super.status,
    super.step,
    super.media,
    String? caption,
    List<String>? hashtags,
    super.errorMessage = '',
    super.albums,
    super.currentAlbum,
    super.assets,
    super.currentAsset,
    super.isEnd,
  }) {
    this.hashtags = hashtags ?? [];
    this.caption = caption ?? '';
  }

  @override
  CreateFeedState copyWith({
    String? id,
    Status? status,
    CreateMediaStep? step,
    File? media,
    String? caption,
    List<String>? hashtags,
    String? errorMessage,
    List<AssetPathEntity>? albums,
    AssetPathEntity? currentAlbum,
    List<AssetEntity>? assets,
    AssetEntity? currentAsset,
    bool? isEnd,
  }) =>
      CreateFeedState(
          id: id ?? this.id,
          status: status ?? this.status,
          step: step ?? this.step,
          media: media ?? this.media,
          caption: caption ?? this.caption,
          hashtags: hashtags ?? this.hashtags,
          errorMessage: errorMessage ?? this.errorMessage,
          albums: albums ?? this.albums,
          currentAlbum: currentAlbum ?? this.currentAlbum,
          assets: assets ?? this.assets,
          currentAsset: currentAsset ?? this.currentAsset,
          isEnd: isEnd ?? this.isEnd);
}
