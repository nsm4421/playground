part of 'display_diary.bloc.dart';

@sealed
final class DisplayDiaryEvent {}

final class FetchDiariesEvent extends DisplayDiaryEvent {
  final bool refresh;
  final int take;

  FetchDiariesEvent({this.refresh = false, this.take = 20});
}
