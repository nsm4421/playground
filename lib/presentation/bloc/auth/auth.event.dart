part of "auth.bloc.dart";

@immutable
sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class InitAuthEvent extends AuthenticationEvent {}

final class SignInWithGoogleEvent extends AuthenticationEvent {}

final class SignOutEvent extends AuthenticationEvent {}
