part of 'display_registration.bloc.dart';

@sealed
class DisplayRegistrationsEvent {}

class InitDisplayRegistrationEvent extends DisplayRegistrationsEvent {
  final Status? status;
  final List<RegistrationEntity>? registrations;
  final String? errorMessage;

  InitDisplayRegistrationEvent(
      {this.status, this.registrations, this.errorMessage});
}

class FetchRegistrationsEvent extends DisplayRegistrationsEvent {
  final bool refresh;

  FetchRegistrationsEvent({this.refresh = false});
}
