part of 'create_feed.bloc.dart';

class CreateFeedState {
  late final String id;
  late final List<AssetPathEntity> albums;
  late final List<AssetEntity> assets;
  late final List<String> hashtags;
  final Status status;
  final CreateMediaStep step;
  final File? media;
  final AssetPathEntity? currentAlbum;
  final AssetEntity? currentAsset;
  final String caption;
  final String? errorMessage;
  final bool isEnd;

  CreateFeedState(
      {String? id,
      this.status = Status.initial,
      this.step = CreateMediaStep.permission,
      this.media,
      this.currentAlbum,
      this.currentAsset,
      this.caption = '',
      this.errorMessage,
      this.isEnd = false,
      List<AssetPathEntity>? albums,
      List<AssetEntity>? assets,
      List<String>? hashtags}) {
    this.id = id ?? const Uuid().v4();
    this.albums = albums ?? <AssetPathEntity>[];
    this.assets = assets ?? <AssetEntity>[];
    this.hashtags = hashtags ?? <String>[];
  }

  CreateFeedState copyWith(
          {String? id,
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
          bool? isEnd}) =>
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

enum CreateMediaStep {
  permission,
  selectMedia,
  detail,
  uploading,
  done;
}
