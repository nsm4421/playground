part of 'edit_diary.bloc.dart';

@sealed
final class EditDiaryEvent {}

final class InitializeEvent extends EditDiaryEvent {}

final class UpdateCaptionEvent extends EditDiaryEvent {
  final int index;
  final String caption;

  UpdateCaptionEvent({required this.index, required this.caption});
}

final class UpdateImageEvent extends EditDiaryEvent {
  final int index;
  final File? image;

  UpdateImageEvent({required this.index, required this.image});
}

final class AddPageEvent extends EditDiaryEvent {}

final class DeletePageEvent extends EditDiaryEvent {}

final class UpdateMetaDataEvent extends EditDiaryEvent {
  final String? location;
  final List<String> hashtags;

  UpdateMetaDataEvent({required this.location, required this.hashtags});
}

final class MovePageEvent extends EditDiaryEvent {
  final int page;

  MovePageEvent(this.page);
}

final class MoveStepEvent extends EditDiaryEvent {
  final EditDiaryStep step;

  MoveStepEvent(this.step);
}

final class SubmitDiaryEvent extends EditDiaryEvent {}
