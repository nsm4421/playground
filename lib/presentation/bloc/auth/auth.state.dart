part of '../export.bloc.dart';

class AuthState {
  final Status status;
  final UserEntity? user;
  final String message;

  AuthState({this.status = Status.initial, this.user, this.message = ''});

  AuthState copyWith({Status? status, String? message}) {
    return AuthState(
        status: status ?? this.status, message: message ?? this.message);
  }

  AuthState copyWithUser(UserEntity? user) {
    return AuthState(status: status, user: user, message: message);
  }
}
