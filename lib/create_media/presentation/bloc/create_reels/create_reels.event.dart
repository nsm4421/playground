part of 'create_reels.bloc.dart';

@sealed
final class CreateReelsEvent {}

final class FetchAlbumsEvent extends CreateReelsEvent {
  final int minHeight; // 가져올 이미지의 최소 높이
  final int take; // 가져올 이미지 개수

  FetchAlbumsEvent({this.minHeight = 50, this.take = 20});
}

final class SelectAlbumEvent extends CreateReelsEvent {
  final AssetPathEntity album;
  final int take; // 가져올 이미지 개수

  SelectAlbumEvent({required this.album, this.take = 20});
}

final class SelectAssetEvent extends CreateReelsEvent {
  final AssetEntity asset;

  SelectAssetEvent(this.asset);
}

final class FetchMoreAssetsEvent extends CreateReelsEvent {
  final int take;

  FetchMoreAssetsEvent({this.take = 20});
}

final class UpdateStateEvent extends CreateReelsEvent {
  final Status? status;
  final String? caption;
  final CreateMediaStep? step;

  UpdateStateEvent({this.status, this.caption, this.step});
}

final class UploadEvent extends CreateReelsEvent {}
