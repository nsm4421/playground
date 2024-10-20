part of 'registration.bloc.dart';

class EditRegistrationState {
  final MeetingEntity _meeting;
  final Status status;
  late final List<RegistrationEntity> registrations;
  final String errorMessage;

  EditRegistrationState(this._meeting,
      {this.status = Status.initial,
      List<RegistrationEntity>? registrations,
      this.errorMessage = ''}) {
    this.registrations = registrations ?? [];
  }

  MeetingEntity get meeting => _meeting;

  EditRegistrationState copyWith(
      {Status? status,
      List<RegistrationEntity>? registrations,
      String? errorMessage,
      bool? isIn}) {
    return EditRegistrationState(_meeting,
        status: status ?? this.status,
        registrations: registrations ?? this.registrations,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
