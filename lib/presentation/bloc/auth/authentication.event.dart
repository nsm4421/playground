part of 'authentication.bloc.dart';

@sealed
abstract class AuthenticationEvent {}

final class UpdateCurrentUserEvent extends AuthenticationEvent {
  final PresenceEntity? presence;

  UpdateCurrentUserEvent(this.presence);
}

final class SignInWithEmailAndPasswordEvent extends AuthenticationEvent {
  final String email;
  final String password;

  SignInWithEmailAndPasswordEvent(
      {required this.email, required this.password});
}

final class SignUpWithEmailAndPasswordEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String username;

  SignUpWithEmailAndPasswordEvent(
      {required this.email, required this.password, required this.username});
}

final class SignOutEvent extends AuthenticationEvent {}
