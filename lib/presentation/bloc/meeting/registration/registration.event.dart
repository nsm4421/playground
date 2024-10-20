part of 'registration.bloc.dart';

@sealed
class EditRegistrationEvent {}

class InitialRegistrationEvent extends EditRegistrationEvent {
  final Status? status;
  final List<RegistrationEntity>? registrations;
  final String? errorMessage;

  InitialRegistrationEvent(
      {this.status, this.registrations, this.errorMessage});
}

class FetchRegistrationEvent extends EditRegistrationEvent {}

class RegisterMeetingEvent extends EditRegistrationEvent {
  final String introduce;

  RegisterMeetingEvent({required this.introduce});
}

class CancelRegistrationEvent extends EditRegistrationEvent {}
