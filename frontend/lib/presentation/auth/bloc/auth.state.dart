part of "auth.bloc.dart";

@immutable
sealed class AuthenticationState {
  const AuthenticationState();
}

final class InitialAuthState extends AuthenticationState {}

final class AuthLoadingState extends AuthenticationState {}

final class AuthSuccessState extends AuthenticationState {
  final UserEntity user;

  const AuthSuccessState(this.user);
}

final class AuthFailureState extends AuthenticationState {
  final String message;

  const AuthFailureState(this.message);
}
