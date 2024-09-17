part of 'create_feed.bloc.dart';

@sealed
final class CreateFeedEvent {}

final class AskPermissionEvent extends CreateFeedEvent {}

final class FetchAlbumsEvent extends CreateFeedEvent {
  final int minHeight; // 가져올 이미지의 최소 높이
  final int take; // 가져올 이미지 개수

  FetchAlbumsEvent({this.minHeight = 100, this.take = 20});
}

final class SelectAlbumEvent extends CreateFeedEvent {
  final AssetPathEntity album;
  final int take; // 가져올 이미지 개수

  SelectAlbumEvent({required this.album, this.take = 20});
}

final class SelectAssetEvent extends CreateFeedEvent {
  final AssetEntity asset;

  SelectAssetEvent(this.asset);
}

final class FetchMoreAssetsEvent extends CreateFeedEvent {
  final int take;

  FetchMoreAssetsEvent({this.take = 20});
}

final class UpdateStateEvent extends CreateFeedEvent {
  final String? id;
  final Status? status;
  final String? caption;
  final List<String>? hashtags;
  final CreateMediaStep? step;

  UpdateStateEvent(
      {this.id, this.status, this.caption, this.hashtags, this.step});
}

final class UploadEvent extends CreateFeedEvent {}
