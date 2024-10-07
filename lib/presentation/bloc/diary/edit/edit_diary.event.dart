part of 'edit_diary.bloc.dart';

@sealed
final class EditDiaryEvent {}

/// 초기화
final class LoadDiaryEvent extends EditDiaryEvent {}

final class ResetDiaryEvent extends EditDiaryEvent {}

final class InitializeEvent extends EditDiaryEvent {
  final Status? status;
  final String? errorMessage;

  InitializeEvent({this.status, this.errorMessage});
}

/// Editor 상태변경
final class UpdateEditorEvent extends EditDiaryEvent {
  final String? content;
  final String? location;
  final List<String>? hashtags;

  UpdateEditorEvent({this.content, this.location, this.hashtags});
}

final class AddAssetEvent extends EditDiaryEvent {
  final File image;

  AddAssetEvent(this.image);
}

final class ChangeAssetEvent extends EditDiaryEvent {
  final int index;
  final DiaryAsset asset;

  ChangeAssetEvent({required this.index, required this.asset});
}

final class UnSelectAssetEvent extends EditDiaryEvent {
  final int index;

  UnSelectAssetEvent(this.index);
}

/// 제출 이벤트
final class SubmitDiaryEvent extends EditDiaryEvent {}
