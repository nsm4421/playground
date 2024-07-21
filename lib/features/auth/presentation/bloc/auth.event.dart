part of "auth.bloc.dart";

@immutable
sealed class AuthEvent {}

final class InitAuthEvent extends AuthEvent {}

final class SignUpWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });
}

final class SignInWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });
}

final class SignOutEvent extends AuthEvent {}
