part of 'bloc.dart';

@sealed
final class CreateReelsEvent {}

final class OnMountEvent extends CreateReelsEvent {
  final int take;

  OnMountEvent({this.take = 20});
}

final class AskPermissionEvent extends CreateReelsEvent {}

final class InitEvent extends CreateReelsEvent {
  final Status? status;
  final String? message;
  final String? caption;

  InitEvent({this.status, this.message, this.caption});
}

final class ChangeAssetPathEvent extends CreateReelsEvent {
  final AssetPathEntity assetPath;

  ChangeAssetPathEvent(this.assetPath);
}

final class SelectVideoEvent extends CreateReelsEvent {
  final AssetEntity video;

  SelectVideoEvent(this.video);
}

final class EditCaptionEvent extends CreateReelsEvent {
  final String caption;

  EditCaptionEvent(this.caption);
}

final class FetchMoreAssetEvent extends CreateReelsEvent {
  final int take;

  FetchMoreAssetEvent({this.take = 20});
}

final class SubmitEvent extends CreateReelsEvent {}
