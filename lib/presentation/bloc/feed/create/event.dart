part of 'bloc.dart';

@sealed
final class CreateFeedEvent {}

final class OnMountEvent extends CreateFeedEvent {
  final int take;

  OnMountEvent({this.take = 20});
}

final class AskPermissionEvent extends CreateFeedEvent {}

final class InitEvent extends CreateFeedEvent {
  final Status? status;
  final String? message;
  final String? content;
  final List<String>? hashtags;

  InitEvent({this.status, this.message, this.content, this.hashtags});
}

final class ChangeAssetPathEvent extends CreateFeedEvent {
  final int take;

  final AssetPathEntity assetPath;

  ChangeAssetPathEvent(this.assetPath, {int this.take = 20});
}

final class FetchMoreAssetEvent extends CreateFeedEvent {
  final int take;

  FetchMoreAssetEvent({this.take = 20});
}

final class OnTapImageEvent extends CreateFeedEvent {
  final AssetEntity asset;

  OnTapImageEvent(this.asset);
}

final class SelectImageEvent extends CreateFeedEvent {
  final AssetEntity asset;

  SelectImageEvent(this.asset);
}

final class EditContentEvent extends CreateFeedEvent {
  final String content;

  EditContentEvent(this.content);
}

final class UnSelectImageEvent extends CreateFeedEvent {}

final class SubmitEvent extends CreateFeedEvent {}
