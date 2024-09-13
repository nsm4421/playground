part of 'create_feed.bloc.dart';

class CreateFeedState extends BaseState {
  final String caption;
  final List<String> hashtags;
  final List<AssetPathEntity> albums;
  final AssetPathEntity? currentAlbum;
  final List<AssetEntity> assets;
  final AssetEntity? currentAsset;
  final bool isAuth;
  final bool isEnd;

  CreateFeedState({
    required super.id,
    super.status = Status.initial,
    super.step = CreateMediaStep.selectMedia,
    super.media,
    this.caption = '',
    required this.hashtags,
    super.errorMessage = '',
    required this.albums,
    this.currentAlbum,
    required this.assets,
    this.currentAsset,
    this.isAuth = false,
    this.isEnd = false,
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
