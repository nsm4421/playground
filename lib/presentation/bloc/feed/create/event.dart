part of 'bloc.dart';

@sealed
final class CreateFeedEvent {}

final class OnMountEvent extends CreateFeedEvent {}

final class AskPermissionEvent extends CreateFeedEvent {}

final class InitEvent extends CreateFeedEvent {
  final Status? status;
  final String? message;
  final String? content;

  InitEvent({this.status, this.message, this.content});
}

final class ChangeAssetPathEvent extends CreateFeedEvent {
  final AssetPathEntity assetPath;

  ChangeAssetPathEvent(this.assetPath);
}

final class OnTapImageEvent extends CreateFeedEvent {
  final AssetEntity asset;

  OnTapImageEvent(this.asset);
}

final class SelectImageEvent extends CreateFeedEvent {
  final AssetEntity asset;

  SelectImageEvent(this.asset);
}

final class EditCaptionEvent extends CreateFeedEvent {
  final String content;

  EditCaptionEvent(this.content);
}

final class UnSelectImageEvent extends CreateFeedEvent {}

final class SubmitEvent extends CreateFeedEvent {}
