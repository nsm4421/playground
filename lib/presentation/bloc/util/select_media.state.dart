part of '../export.bloc.dart';

class SelectMediaState {
  final RequestType type;
  final bool isAuth;
  final bool mounted;
  final Status status;
  final String errorMessage;
  late final List<AssetPathEntity> albums;
  late final List<AssetEntity> assets;
  late final List<AssetEntity> selected;
  final bool isEnd;
  final int page;
  final int albumIndex;

  AssetPathEntity get currentAlbum => albums[albumIndex];

  SelectMediaState({
    this.type = RequestType.image,
    this.isAuth = false,
    this.mounted = false,
    this.status = Status.initial,
    this.errorMessage = '',
    List<AssetPathEntity>? albums,
    List<AssetEntity>? assets,
    List<AssetEntity>? selected,
    this.isEnd = false,
    this.page = 0,
    this.albumIndex = 0,
  }) {
    this.albums = albums ?? [];
    this.assets = assets ?? [];
    this.selected = selected ?? [];
  }

  SelectMediaState copyWith({
    RequestType? type,
    bool? isAuth,
    bool? mounted,
    Status? status,
    String? errorMessage,
    List<AssetPathEntity>? albums,
    List<AssetEntity>? assets,
    List<AssetEntity>? selected,
    bool? isEnd,
    int? page,
    int? albumIndex,
  }) {
    return SelectMediaState(
      type: type ?? this.type,
      isAuth: isAuth ?? this.isAuth,
      mounted: mounted ?? this.mounted,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      albums: albums ?? this.albums,
      assets: assets ?? this.assets,
      selected: selected ?? this.selected,
      isEnd: isEnd ?? this.isEnd,
      page: page ?? this.page,
      albumIndex: albumIndex ?? this.albumIndex,
    );
  }
}
