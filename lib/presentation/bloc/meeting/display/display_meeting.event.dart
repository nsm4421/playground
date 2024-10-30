part of 'display_meeting.bloc.dart';

class SearchMeetingEvent extends FetchEvent<MeetingEntity> {
  final MeetingSearchOption option;

  SearchMeetingEvent({super.refresh, super.take, required this.option});
}

class MeetingFilterOffEvent extends FetchEvent<MeetingEntity> {}
