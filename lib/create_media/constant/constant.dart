import 'dart:io';

import 'package:photo_manager/photo_manager.dart';

import '../../shared/shared.export.dart';

enum CreateMediaMode {
  feed('피드'),
  reels('릴스');

  final String label;

  const CreateMediaMode(this.label);
}

enum CreateMediaStep {
  selectMedia,
  detail,
  uploading,
  done;
}

abstract class BaseState {
  final String id;
  final Status status;
  final CreateMediaStep step;
  final File? media;
  final String errorMessage;
  late final List<AssetPathEntity> albums;
  final AssetPathEntity? currentAlbum;
  late final List<AssetEntity> assets;
  final AssetEntity? currentAsset;
  final bool isAuth;
  final bool isEnd;

  BaseState({
    required this.id,
    required this.status,
    this.step = CreateMediaStep.selectMedia,
    required this.media,
    this.errorMessage = '',
    List<AssetPathEntity>? albums,
    this.currentAlbum,
    List<AssetEntity>? assets,
    this.currentAsset,
    this.isAuth = false,
    this.isEnd = false,
  }) {
    this.albums = albums ?? [];
    this.assets = assets ?? [];
  }

  BaseState copyWith({
    String? id,
    Status? status,
    CreateMediaStep? step,
    File? media,
    String? errorMessage,
    List<AssetPathEntity>? albums,
    AssetPathEntity? currentAlbum,
    List<AssetEntity>? assets,
    AssetEntity? currentAsset,
    bool? isAuth,
    bool? isEnd,
  });
}
