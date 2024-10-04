part of 'authentication.bloc.dart';

enum AuthenticationStep {
  signUp,
  signIn,
  authorized;
}

class AuthenticationState {
  final Status status;
  final AuthenticationStep step;
  final PresenceEntity? currentUser;
  final String errorMessage;

  AuthenticationState(
      {this.status = Status.initial,
      this.step = AuthenticationStep.signIn,
      this.currentUser,
      this.errorMessage = ''});

  AuthenticationState _copyWith(
      {Status? status,
      AuthenticationStep? step,
      PresenceEntity? currentUser,
      String? errorMessage}) {
    return AuthenticationState(
        status: status ?? this.status,
        step: step ?? this.step,
        currentUser: currentUser ?? this.currentUser,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  AuthenticationState copyWith(
      {Status? status,
      AuthenticationStep? step,
      String? errorMessage}) {
    return _copyWith(
        status: status,
        step: step,
        errorMessage: errorMessage,
        currentUser: currentUser);
  }

  AuthenticationState copyWithCurrentUser(PresenceEntity? currentUser) {
    return _copyWith(currentUser: currentUser);
  }
}
