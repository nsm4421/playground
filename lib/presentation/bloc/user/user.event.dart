part of "user.bloc.dart";

@immutable
sealed class UserEvent {}

final class InitUserEvent extends UserEvent {}

final class SignInEvent extends UserEvent {
  final User user;

  SignInEvent(this.user);
}

final class SignOutEvent extends UserEvent {}

final class InitOnBoardingEvent extends UserEvent {
  final User sessionUser;

  InitOnBoardingEvent(this.sessionUser);
}

final class OnBoardingEvent extends UserEvent {
  final User sessionUser;
  final File image;
  final String nickname;
  final String description;

  OnBoardingEvent({
    required this.sessionUser,
    required this.image,
    required this.nickname,
    required this.description,
  });
}
