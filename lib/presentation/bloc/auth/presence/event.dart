part of 'bloc.dart';

@sealed
final class AuthenticationEvent {}

final class UpdateCurrentUserEvent extends AuthenticationEvent {}

final class SignOutEvent extends AuthenticationEvent {}
