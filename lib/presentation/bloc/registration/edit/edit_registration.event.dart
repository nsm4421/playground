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

  RegisterMeetingEvent({required this.introduce});
}

class CancelRegistrationEvent extends EditRegistrationEvent {}
