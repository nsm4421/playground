part of 'user.bloc.dart';

@immutable
sealed class UserEvent {}

final class InitUserEvent extends UserEvent {}

final class SignUpWithEmailAndPasswordEvent extends UserEvent {
  final String email;
  final String password;

  SignUpWithEmailAndPasswordEvent(
      {required this.email, required this.password});
}

final class SignInEvent extends UserEvent {}

final class SignInWithGoogleEvent extends SignInEvent {}

final class SignInWithEmailAndPasswordEvent extends SignInEvent {
  final String email;
  final String password;

  SignInWithEmailAndPasswordEvent(
      {required this.email, required this.password});
}

final class OnBoardingEvent extends UserEvent {
  final File image;
  final String nickname;
  final String description;

  OnBoardingEvent(
      {required this.image, required this.nickname, required this.description});
}

final class FetchAccountEvent extends UserEvent {
  final User sessionUser;

  FetchAccountEvent(this.sessionUser);
}

final class SignOutEvent extends UserEvent {}
