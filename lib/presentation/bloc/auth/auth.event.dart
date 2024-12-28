part of '../export.bloc.dart';

final class AuthEvent {}

final class InitEvent extends AuthEvent {
  final Status? status;
  final String? message;

  InitEvent({this.status, this.message});
}

final class GetUserEvent extends AuthEvent {
  final bool isOnMount;

  GetUserEvent({this.isOnMount = false});
}

final class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final String nickname;

  SignUpEvent(
      {required this.email,
      required this.password,
      required this.username,
      required this.nickname});
}

final class SignInEvent extends AuthEvent {
  final String username;
  final String password;

  SignInEvent({required this.username, required this.password});
}

final class SignOutEvent extends AuthEvent {}
