part of 'edit_feed.bloc.dart';

@sealed
final class EditFeedEvent {}

/// 초기화
final class LoadFeedEvent extends EditFeedEvent {}

final class ResetFeedEvent extends EditFeedEvent {}

final class InitializeEvent extends EditFeedEvent {
  final Status? status;
  final String? errorMessage;

  InitializeEvent({this.status, this.errorMessage});
}

/// Editor 상태변경
final class UpdateEditorEvent extends EditFeedEvent {
  final String? content;
  final String? location;
  final List<String>? hashtags;

  UpdateEditorEvent({this.content, this.location, this.hashtags});
}

final class AddAssetEvent extends EditFeedEvent {
  final File image;

  AddAssetEvent(this.image);
}

final class ChangeAssetEvent extends EditFeedEvent {
  final int index;
  final FeedAsset asset;

  ChangeAssetEvent({required this.index, required this.asset});
}

final class UnSelectAssetEvent extends EditFeedEvent {
  final int index;

  UnSelectAssetEvent(this.index);
}

/// 제출 이벤트
final class SubmitFeedEvent extends EditFeedEvent {}
