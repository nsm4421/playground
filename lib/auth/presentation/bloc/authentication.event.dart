part of 'authentication.bloc.dart';

sealed class AuthenticationEvent {}

final class InitAuthEvent extends AuthenticationEvent {}

final class AuthChangedEvent extends AuthenticationEvent {
  final User? user;

  AuthChangedEvent(this.user);
}

final class CheckUsernameEvent extends AuthenticationEvent {
  final String username;

  CheckUsernameEvent(this.username);
}

final class SignInWithEmailAndPasswordEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SignInWithEmailAndPasswordEvent(this.email, this.password);
}

final class SignUpWithEmailAndPasswordEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String username;
  final File profileImage;

  SignUpWithEmailAndPasswordEvent(
      {required this.email,
      required this.password,
      required this.username,
      required this.profileImage});
}

final class SignOutEvent extends AuthenticationEvent {}

final class UpdateProfileEvent extends AuthenticationEvent {}
