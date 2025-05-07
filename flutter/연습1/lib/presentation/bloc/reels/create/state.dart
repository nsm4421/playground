part of 'bloc.dart';

class CreateReelsState extends BaseState {
  final String id;
  final String caption;
  late final List<AssetPathEntity> album;
  final AssetPathEntity? currentAssetPath; // 현재 선택한 폴더 경로
  late final List<AssetEntity> assets; // 현재 보여주고 있는 비디오 목록
  final AssetEntity? video; // 선택한 비디오
  final bool isAuth;
  final bool isEnd;

  CreateReelsState(
      {required this.id,
      super.status,
      super.message,
      this.caption = '',
      List<AssetPathEntity>? album,
      this.currentAssetPath,
      List<AssetEntity>? assets,
      this.video,
      this.isAuth = false,
      this.isEnd = false}) {
    this.album = album ?? [];
    this.assets = assets ?? [];
  }

  @override
  CreateReelsState copyWith(
      {Status? status,
      String? message,
      String? caption,
      List<AssetPathEntity>? album,
      AssetPathEntity? assetPath,
      List<AssetEntity>? assets,
      AssetEntity? video,
      bool? isAuth,
      bool? isEnd}) {
    return CreateReelsState(
      id: id,
      status: status ?? this.status,
      message: message ?? this.message,
      caption: caption ?? this.caption,
      album: album ?? this.album,
      currentAssetPath: assetPath ?? currentAssetPath,
      assets: assets ?? this.assets,
      video: video ?? this.video,
      isAuth: isAuth ?? this.isAuth,
      isEnd: isEnd ?? this.isEnd,
    );
  }
}
