import 'dart:io';

import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

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
  late final String id;
  late final Status status;
  late final CreateMediaStep step;
  final File? media;
  late final String errorMessage;
  late final List<AssetPathEntity> albums;
  final AssetPathEntity? currentAlbum;
  late final List<AssetEntity> assets;
  final AssetEntity? currentAsset;
  late final bool isEnd;

  BaseState(
      {String? id,
      Status? status,
      CreateMediaStep? step,
      required this.media,
      String? errorMessage,
      List<AssetPathEntity>? albums,
      this.currentAlbum,
      List<AssetEntity>? assets,
      this.currentAsset,
      bool? isAuth,
      bool? isEnd}) {
    this.id = id ?? const Uuid().v4();
    this.status = status ?? Status.initial;
    this.step = step ?? CreateMediaStep.selectMedia;
    this.errorMessage = errorMessage ?? '';
    this.albums = albums ?? [];
    this.assets = assets ?? [];
    this.isEnd = isEnd ?? false;
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
    bool? isEnd,
  });
}
