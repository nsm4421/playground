part of "auth.bloc.dart";

@immutable
sealed class AuthEvent {}

final class InitAuthEvent extends AuthEvent {}

final class UpdateCurrentUserEvent extends AuthEvent {
  final UserEntity user;

  UpdateCurrentUserEvent(this.user);
}

final class SignUpWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  final String nickname;
  final String profileUrl;

  SignUpWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
    required this.nickname,
    required this.profileUrl,
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
