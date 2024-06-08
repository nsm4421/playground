part of "account.bloc.dart";

@immutable
sealed class AccountEvent {}

final class InitAccountEvent extends AccountEvent {}

final class SignInEvent extends AccountEvent {
  final User user;

  SignInEvent(this.user);
}

final class SignOutEvent extends AccountEvent {}

final class InitOnBoardingEvent extends AccountEvent {
  final User sessionUser;

  InitOnBoardingEvent(this.sessionUser);
}

final class OnBoardingEvent extends AccountEvent {
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
