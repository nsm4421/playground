part of 'bloc.dart';

class CreateFeedState extends BaseState {
  final String id;
  final String content;
  late final List<String> hashtags;
  late final List<String> captions;
  late final List<AssetPathEntity> album;
  final AssetPathEntity? currentAssetPath; // 현재 선택한 폴더 경로
  late final List<AssetEntity> assets;
  final AssetEntity? currentAsset; // 현재 보여주고 있는 asset
  late final List<AssetEntity> images;
  final bool isAuth;
  final bool isEnd; // 현재 asset path에서 이미지를 다 가져왔는지 여부

  CreateFeedState(
      {required this.id,
      super.status,
      super.message,
      this.content = '',
      List<String>? hashtags,
      List<String>? captions,
      List<AssetPathEntity>? album,
      this.currentAssetPath,
      List<AssetEntity>? assets,
      this.currentAsset,
      List<AssetEntity>? selected,
      this.isAuth = false,
      this.isEnd = false}) {
    this.hashtags = hashtags ?? [];
    this.captions = captions ?? [];
    this.album = album ?? [];
    this.assets = assets ?? [];
    this.images = selected ?? [];
  }

  @override
  CreateFeedState copyWith(
      {Status? status,
      String? message,
      String? content,
      List<String>? captions,
      List<String>? hashtags,
      List<AssetEntity>? selected,
      List<AssetPathEntity>? album,
      AssetPathEntity? assetPath,
      List<AssetEntity>? assets,
      AssetEntity? currentImage,
      bool? isAuth,
      bool? isEnd}) {
    return CreateFeedState(
        id: id,
        status: status ?? this.status,
        message: message ?? this.message,
        content: content ?? this.content,
        captions: captions ?? this.captions,
        hashtags: hashtags ?? this.hashtags,
        selected: selected ?? this.images,
        album: album ?? this.album,
        currentAsset: currentImage ?? this.currentAsset,
        currentAssetPath: assetPath ?? this.currentAssetPath,
        assets: assets ?? this.assets,
        isAuth: isAuth ?? this.isAuth,
        isEnd: isEnd ?? this.isEnd);
  }

  int get index => images.indexOf(currentAsset!);
}
