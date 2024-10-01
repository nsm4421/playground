part of 'authentication.bloc.dart';

class AuthenticationState {
  final Status status;
  final bool isAuthorized;
  final PresenceEntity? currentUser;
  final String errorMessage;

  AuthenticationState(
      {this.status = Status.initial,
      this.isAuthorized = false,
      this.currentUser,
      this.errorMessage = ''});

  AuthenticationState _copyWith(
      {Status? status,
      bool? isAuthorized,
      PresenceEntity? currentUser,
      String? errorMessage}) {
    return AuthenticationState(
        status: status ?? this.status,
        isAuthorized: isAuthorized ?? this.isAuthorized,
        currentUser: currentUser ?? this.currentUser,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  AuthenticationState copyWith(
      {Status? status, bool? isAuthorized, String? errorMessage}) {
    return _copyWith(
        status: status,
        isAuthorized: isAuthorized,
        errorMessage: errorMessage,
        currentUser: this.currentUser);
  }

  AuthenticationState copyWithCurrentUser(PresenceEntity? currentUser) {
    return _copyWith(currentUser: currentUser);
  }
}
