part of 'create_feed.bloc.dart';

class CreateFeedState extends BaseState {
  final String caption;
  final List<String> hashtags;

  CreateFeedState({
    required super.id,
    super.status = Status.initial,
    super.step = CreateMediaStep.selectMedia,
    super.media,
    this.caption = '',
    required this.hashtags,
    super.errorMessage = '',
    super.albums,
    super.currentAlbum,
    super.assets,
    super.currentAsset,
    super.isAuth = false,
    super.isEnd = false,
  });

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
    bool? isAuth,
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
          isAuth: isAuth ?? this.isAuth,
          isEnd: isEnd ?? this.isEnd);
}
