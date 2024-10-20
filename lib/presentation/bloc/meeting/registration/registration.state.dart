part of 'registration.bloc.dart';

class EditRegistrationState {
  final MeetingEntity _meeting;
  final Status status;
  late final List<PresenceEntity> accompanies;
  final String errorMessage;

  EditRegistrationState(this._meeting,
      {this.status = Status.initial,
      List<PresenceEntity>? accompanies,
      this.errorMessage = ''}) {
    this.accompanies = accompanies ?? [];
  }

  MeetingEntity get meeting => _meeting;

  EditRegistrationState copyWith(
      {Status? status,
      List<PresenceEntity>? accompanies,
      String? errorMessage,
      bool? isIn}) {
    return EditRegistrationState(_meeting,
        status: status ?? this.status,
        accompanies: accompanies ?? this.accompanies,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
