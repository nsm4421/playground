part of '../export.bloc.dart';

final class AuthEvent {}

final class InitAuthEvent extends AuthEvent {
  final Status? status;
  final String? message;

  InitAuthEvent({this.status, this.message});
}

final class GetUserEvent extends AuthEvent {
  final bool isOnMount;

  GetUserEvent({this.isOnMount = false});
}

final class SignInEvent extends AuthEvent {
  final String username;
  final String password;

  SignInEvent({required this.username, required this.password});
}

final class SignOutEvent extends AuthEvent {}
