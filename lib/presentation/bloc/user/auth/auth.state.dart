part of 'auth.cubit.dart';

@immutable
sealed class AuthenticationState {
  const AuthenticationState();
}

final class NotAuthenticatedState extends AuthenticationState {}

final class AuthLoadingState extends AuthenticationState {}

final class AuthenticatedState extends AuthenticationState {
  final User user;

  const AuthenticatedState(this.user);
}

final class AuthFailureState extends AuthenticationState {
  final String? message;

  const AuthFailureState({this.message});
}
