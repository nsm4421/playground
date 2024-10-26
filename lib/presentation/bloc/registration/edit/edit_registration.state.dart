part of 'edit_registration.bloc.dart';

class EditRegistrationState {
  final MeetingEntity _meeting;
  final Status status;
  final String errorMessage;

  EditRegistrationState(this._meeting,
      {this.status = Status.initial, this.errorMessage = ''});

  EditRegistrationState copyWith(
      {Status? status, bool? isIn, String? errorMessage}) {
    return EditRegistrationState(_meeting,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
