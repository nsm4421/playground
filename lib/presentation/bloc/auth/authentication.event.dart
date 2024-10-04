part of 'authentication.bloc.dart';

@sealed
abstract class AuthenticationEvent {}

final class InitializeEvent extends AuthenticationEvent {
  final AuthenticationStep? step;
  final Status? status;
  final PresenceEntity? presence;
  final String? errorMessage;

  InitializeEvent({this.step, this.status, this.presence, this.errorMessage});
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
  final File profileImage;

  SignUpWithEmailAndPasswordEvent(
      {required this.email,
      required this.password,
      required this.username,
      required this.profileImage});
}

final class SignOutEvent extends AuthenticationEvent {}
