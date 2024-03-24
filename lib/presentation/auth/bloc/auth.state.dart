part of "auth.bloc.dart";

@immutable
sealed class AuthState {
  const AuthState();
}

final class InitialAuthState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final UserEntity user;

  const AuthSuccessState(this.user);
}

final class AuthFailureState extends AuthState {
  final String message;

  const AuthFailureState(this.message);
}
