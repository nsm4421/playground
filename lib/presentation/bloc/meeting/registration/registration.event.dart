part of 'registration.bloc.dart';

@sealed
class EditRegistrationEvent {
  final String meetingId;

  EditRegistrationEvent(this.meetingId);
}

class FetchMeetingEvent extends EditRegistrationEvent {
  FetchMeetingEvent(super.meetingId);
}

class RegisterMeetingEvent extends EditRegistrationEvent {
  final PresenceEntity currentUser;

  RegisterMeetingEvent(super.meetingId, {required this.currentUser});
}

class CancelMeetingEvent extends EditRegistrationEvent {
  final PresenceEntity currentUser;

  CancelMeetingEvent(super.meetingId, {required this.currentUser});
}
