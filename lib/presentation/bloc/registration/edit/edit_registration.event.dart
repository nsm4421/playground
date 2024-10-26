part of 'edit_registration.bloc.dart';

@sealed
class EditRegistrationEvent {}

class InitEditRegistrationEvent extends EditRegistrationEvent {
  final Status? status;
  final String? errorMessage;

  InitEditRegistrationEvent({this.status, this.errorMessage});
}

class RegisterMeetingEvent extends EditRegistrationEvent {
  final String introduce;

  RegisterMeetingEvent(this.introduce);
}

class DeleteRegistrationEvent extends EditRegistrationEvent {}

class PermitRegistrationEvent extends EditRegistrationEvent {
  final String registrationId;

  PermitRegistrationEvent(this.registrationId);
}

class CancelPermitRegistrationEvent extends EditRegistrationEvent {
  final String registrationId;

  CancelPermitRegistrationEvent(this.registrationId);
}
