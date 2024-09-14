part of 'create_reels.bloc.dart';

class CreateReelsState extends BaseState {
  late final String caption;

  CreateReelsState({
    super.id,
    super.status,
    super.step,
    super.media,
    String? caption,
    super.errorMessage = '',
    super.albums,
    super.currentAlbum,
    super.assets,
    super.currentAsset,
    super.isEnd,
  }) {
    this.caption = caption ?? '';
  }

  @override
  CreateReelsState copyWith({
    String? id,
    Status? status,
    CreateMediaStep? step,
    File? media,
    String? caption,
    String? errorMessage,
    List<AssetPathEntity>? albums,
    AssetPathEntity? currentAlbum,
    List<AssetEntity>? assets,
    AssetEntity? currentAsset,
    bool? isEnd,
  }) =>
      CreateReelsState(
          id: id ?? this.id,
          status: status ?? this.status,
          step: step ?? this.step,
          media: media ?? this.media,
          caption: caption ?? this.caption,
          errorMessage: errorMessage ?? this.errorMessage,
          albums: albums ?? this.albums,
          currentAlbum: currentAlbum ?? this.currentAlbum,
          assets: assets ?? this.assets,
          currentAsset: currentAsset ?? this.currentAsset,
          isEnd: isEnd ?? this.isEnd);
}
