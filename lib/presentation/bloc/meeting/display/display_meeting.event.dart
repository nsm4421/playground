part of 'display_meeting.bloc.dart';

@sealed
class DisplayMeetingEvent {}

class FetchMeetingEvent extends DisplayMeetingEvent {
  final bool refresh;
  final int take;

  FetchMeetingEvent({this.refresh = false, this.take = 20});
}
