part of 'edit_diary.bloc.dart';

@sealed
final class EditDiaryEvent {}

/// 초기화
final class LoadDiaryEvent extends EditDiaryEvent {}

final class InitializeEvent extends EditDiaryEvent {
  final Status status;
  final EditDiaryStep step;

  InitializeEvent(
      {this.status = Status.initial, this.step = EditDiaryStep.initializing});
}

/// Editor 상태변경
// 캡션 업데이트
final class UpdateCaptionEvent extends EditDiaryEvent {
  final int index;
  final String caption;

  UpdateCaptionEvent({required this.index, required this.caption});
}

// 이미지 업데이트
final class UpdateImageEvent extends EditDiaryEvent {
  final int index;
  final File? image;

  UpdateImageEvent({required this.index, required this.image});
}

// 페이지 추가
final class AddPageEvent extends EditDiaryEvent {}

// 페이지 삭제
final class DeletePageEvent extends EditDiaryEvent {}

// 페이지 이동
final class MovePageEvent extends EditDiaryEvent {
  final int page;

  MovePageEvent(this.page);
}

// 메타 데이터 수정 페이지로 이동
final class MoveToMetaDataPage extends EditDiaryEvent {}

// 메타 데이터 업데이트
final class UpdateMetaDataEvent extends EditDiaryEvent {
  final String? location;
  final List<String> hashtags;

  UpdateMetaDataEvent({required this.location, required this.hashtags});
}

/// 제출 이벤트
final class SubmitDiaryEvent extends EditDiaryEvent {}
