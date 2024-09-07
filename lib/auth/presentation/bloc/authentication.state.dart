part of 'authentication.bloc.dart';

class AuthenticationState {
  final AuthStatus authStatus;
  final Status status;
  final User? user;
  final String? errorMessage;

  AuthenticationState(
      {this.authStatus = AuthStatus.unAuthenticated,
      this.status = Status.initial,
      this.user,
      this.errorMessage});

  AuthenticationState copyWith(
          {AuthStatus? authStatus,
          Status? status,
          User? user,
          String? errorMessage}) =>
      AuthenticationState(
          authStatus: authStatus ?? this.authStatus,
          status: status ?? this.status,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}
