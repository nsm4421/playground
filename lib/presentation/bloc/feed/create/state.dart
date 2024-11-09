part of 'bloc.dart';

class CreateFeedState extends BaseState {
  final String id;
  final String content;
  late final List<String> hashtags;
  late final List<String> captions;
  late final List<AssetPathEntity> album;
  final AssetPathEntity? assetPath; // 현재 선택한 폴더 경로
  late final List<AssetEntity> assets;
  final AssetEntity? currentImage; // 현재 보여주고 있는 asset
  late final List<AssetEntity> selected;
  final bool isAuth;

  CreateFeedState(
      {required this.id,
      super.status,
      super.message,
      this.content = '',
      List<String>? hashtags,
      List<String>? captions,
      List<AssetPathEntity>? album,
      this.assetPath,
      List<AssetEntity>? assets,
      this.currentImage,
      List<AssetEntity>? selected,
      this.isAuth = false}) {
    this.hashtags = hashtags ?? [];
    this.captions = captions ?? [];
    this.album = album ?? [];
    this.assets = assets ?? [];
    this.selected = selected ?? [];
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
      bool? isAuth}) {
    return CreateFeedState(
      id: id,
      status: status ?? this.status,
      message: message ?? this.message,
      content: content ?? this.content,
      captions: captions ?? this.captions,
      hashtags: hashtags ?? this.hashtags,
      selected: selected ?? this.selected,
      album: album ?? this.album,
      currentImage: currentImage ?? this.currentImage,
      assetPath: assetPath ?? this.assetPath,
      assets: assets ?? this.assets,
      isAuth: isAuth ?? this.isAuth,
    );
  }
}
